import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/components/default_button.dart';
import 'package:idaman/models/PostResponseModel.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/models/bantuan_post.dart';
import 'package:idaman/screen/penjual/pelatihan/details/pelatihan_detail_screen.dart';

import '../../../../main.dart';
import 'bantuan_detail_screen.dart';


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}


class _BodyState extends State<Body> {
  List<Umkm> usaha_saya = [];
  Umkm? selUsahaItem;

  String selUsaha = "";

  @override
  void initState() {
    loadUsahaSaya(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BantuanDetailScreenArguments args =
    ModalRoute.of(context)!.settings.arguments as BantuanDetailScreenArguments;

    DateFormat dateFormat;
    DateFormat timeFormat;
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('id');
    timeFormat = new DateFormat.Hms('id');

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Bantuan Permodalan"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if(args.model.photo.toString()!="null")
              Image.network(args.model.photo.toString()),
            if(args.model.photo.toString()=="null")
              Image.asset("assets/images/noimage.png"),
            Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(120),
                1: FixedColumnWidth(10),
                2: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Pelatihan"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(":"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(args.model.bantuan.toString()),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tanggal"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(":"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "${dateFormat.format(DateTime.parse(args.model.tanggal.toString()))}"
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: args.model.keterangan  != null ? Html(
                  data:args.model.keterangan
              ): Text("Tidak ada keterangan"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: DropdownSearch<Umkm>(
                items: usaha_saya,
                maxHeight: 300,
                //onFind: (String? filter) => loadProvinsi(filter),
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Pilih Usaha ",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: (Umkm? value) {
                  String? selected = value?.id.toString();
                  print(value?.id);
                  selUsaha = selected.toString();
                },
                selectedItem: selUsahaItem,
                showSearchBox: false,
                dropdownBuilder: _usahaDropDown,
                popupItemBuilder: _usahaPopupItemBuilder,
              ),
            ),
            DefaultButton(
                text: "DAFTAR",
                press: () async{
                  if(selUsaha.isNotEmpty){
                    APIService api = new APIService();
                    PostResponseModel prm = await api.daftarBantuan(
                        BantuanPostModel(
                            cms_user_id: MyApp.localStorage.getString("id").toString(),
                            umkm_usaha_id: selUsaha,
                            bantuan_id: args.model.id.toString()
                        )
                    );

                    if(prm.api_status==1){
                      final snackBar = SnackBar(
                          content: Text("Behasil melakukan pendaftaran.")
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    }else{
                      final snackBar = SnackBar(
                          content: Text(prm.api_message)
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                  }else{
                    final snackBar = SnackBar(
                        content: Text("Harap pilih usaha yang akan didaftarkan !")
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                warna: Colors.red
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _usahaDropDown(BuildContext context, Umkm? item) {
    if (item == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.only(left:20.0),
      child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.all(0),

          title: Text(item.nama_usaha),
        ),
      ),
    );
  }

  Widget _usahaPopupItemBuilder(BuildContext context, Umkm? item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(
        selected: isSelected,
        title: Text(item?.nama_usaha ?? ''),
      ),
    );
  }

  loadUsahaSaya(BuildContext context) async{
   // print(MyApp.localStorage.get("nik").toString() + ", " + MyApp.localStorage.get("pass").toString());
    //lm = await lc.getCurrentPosition();
    APIService apiService = new APIService();
    await apiService.getUmkm("&nik="+MyApp.localStorage.get("nik").toString() , "0", "0", 0, 10).then((value) {
      usaha_saya = value;
      setState((){});
    });

  }
}
