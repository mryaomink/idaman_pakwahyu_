import '../main.dart';

String autoLoginJS(){
  return "\$('#nik-input').val(${MyApp.localStorage.get("nik").toString()});"
  "\$('#password-input').val(${MyApp.localStorage.get("pass").toString()});"
  "\$( '#submit-button' ).trigger( 'click' );";
}