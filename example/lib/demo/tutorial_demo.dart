
import 'package:wx_dart/wx_dart.dart';

import '../assets/tut/tut01.dart' as tut01;
import '../assets/tut/tut02.dart' as tut02;
import '../assets/tut/tut03.dart' as tut03;
import '../assets/tut/tut04.dart' as tut04;
import '../assets/tut/tut05.dart' as tut05;
import '../assets/tut/tut06.dart' as tut06;
import '../assets/tut/tut07.dart' as tut07;
import '../assets/tut/tut08.dart' as tut08;
import '../assets/tut/tut09.dart' as tut09;
import '../assets/tut/tut10.dart' as tut10;
import '../assets/tut/tut11.dart' as tut11;
import '../assets/tut/tut12.dart' as tut12;


// --------------------------- MyTutorialPage ----------------------------

class MyTutorialPage extends WxPanel
{
  MyTutorialPage( super.parent, super.id, this._tutorial ) 
  {
    final mainSizer = WxBoxSizer( wxVERTICAL );
    setSizer(mainSizer);

    _html = WxHtmlWindow(this, -1);
    mainSizer.add( _html, proportion: 1, flag: wxEXPAND );

    final buttonSizer = WxBoxSizer( wxHORIZONTAL );
    mainSizer.addSizer( buttonSizer, flag: wxALIGN_RIGHT|wxALL, border: 5 );

    final runButton = WxButton(this, -1, "Run!" );
    runButton.setBitmap( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.directions_run, WxSize(24,24) ) );
    buttonSizer.add( runButton );
    buttonSizer.addSpacer( 20 );
    runButton.bindButtonEvent( onRunButton, -1 );

    loadTutorial( _tutorial );

    bindSysColourChangedEvent((_) {
      loadTutorial(_tutorial);
    } );
  }

  void onRunButton( WxCommandEvent event )
  {
    final parent = wxTheApp.getTopWindow() as WxFrame;
      if (_tutorial == "tut01.dart") {
        final frame = tut01.MyFrame( parent );
        frame.show();
      } else 
      if (_tutorial == "tut02.dart") {
        final frame = tut02.MyFrame( parent );
        frame.show();
      } else 
      if (_tutorial == "tut03.dart") {
        final frame = tut03.MyFrame( parent );
        frame.show();
      } else 
      if (_tutorial == "tut04.dart") {
        final frame = tut04.MyFrame( parent );
        frame.show();
      } else 
      if (_tutorial == "tut05.dart") {
        final frame = tut05.MyFrame( parent );
        frame.show();
      } else 
      if (_tutorial == "tut06.dart") {
        final frame = tut06.MyFrame( parent );
        frame.show();
      } else 
      if (_tutorial == "tut07.dart") {
        final frame = tut07.MyFrame( parent );
        frame.show();
      } else 
      if (_tutorial == "tut08.dart") {
        final frame = tut08.MyFrame( parent );
        frame.show();
      } else 
      if (_tutorial == "tut09.dart") {
        final frame = tut09.MyFrame( parent );
        frame.show();
      } else 
      if (_tutorial == "tut10.dart") {
        final frame = tut10.MyFrame( parent );
        frame.show();
      } else 
      if (_tutorial == "tut11.dart") {
        final frame = tut11.MyFrame( parent );
        frame.show();
      } else 
      if (_tutorial == "tut12.dart") {
        final frame = tut12.MyFrame( parent );
        frame.show();
      } 
  }

  String getTutorial() {
    return _tutorial;
  }

  final String _tutorial;
  late WxHtmlWindow _html;

  String replaceKeyWord( String origin, String key ) {
    return origin.replaceAll( key, '<span style="font-weight:bold;">$key</span>' );
  }

  void loadTutorial( String tutorial ) 
  {
      wxLoadStringFromResource(tutorial, (text) {
        String htmltext = "<pre><p>$text\n</pre></p>";
        // htmltext = '---"Hallo"---';
        int startFrom = 0;
        while (htmltext.indexOf('"', startFrom ) != -1) {
          final pos = htmltext.indexOf('"', startFrom );
          final end = htmltext.indexOf('"', pos+1 );
          if (pos < 0) break;
          final part1 = htmltext.substring(0,pos);
          final part2 = htmltext.substring(pos);
          htmltext = '$part1<span style="font-style:italic;color:brown">$part2';
          final part3 = htmltext.substring(0,end+45);
          final part4 = htmltext.substring(end+45);
          htmltext = '$part3</span>$part4';
          startFrom = end + 52;
        }
        startFrom = 0;
        while (htmltext.indexOf('//', startFrom ) != -1) {
          final pos = htmltext.indexOf('//', startFrom );
          final end = htmltext.indexOf('\n', pos )-1;
          if (pos < 0) break;
          final part1 = htmltext.substring(0,pos);
          final part2 = htmltext.substring(pos);
          if (wxTheApp.isDark()) {
            htmltext = '$part1<span style="font-style:italic;color:khaki">$part2';
          } else {
            htmltext = '$part1<span style="font-style:italic;color:green">$part2';
          }
          final part3 = htmltext.substring(0,end+45);
          final part4 = htmltext.substring(end+45);
          htmltext = '$part3</span>$part4';
          startFrom = end + 52;
        }
        htmltext = replaceKeyWord(htmltext, "final" );
        htmltext = replaceKeyWord(htmltext, "import" );
        htmltext = replaceKeyWord(htmltext, "const" );
        htmltext = replaceKeyWord(htmltext, "@override" );
        htmltext = replaceKeyWord(htmltext, "bool" );
        htmltext = replaceKeyWord(htmltext, " int " );
        htmltext = replaceKeyWord(htmltext, "String" );
        htmltext = replaceKeyWord(htmltext, "List" );
        htmltext = replaceKeyWord(htmltext, "super" );
        htmltext = replaceKeyWord(htmltext, "else" );
        htmltext = replaceKeyWord(htmltext, "class" );
        htmltext = replaceKeyWord(htmltext, "extends" );
        htmltext = replaceKeyWord(htmltext, "return" );
        htmltext = replaceKeyWord(htmltext, "null" );
        htmltext = replaceKeyWord(htmltext, "(" );
        htmltext = replaceKeyWord(htmltext, ")" );
        htmltext = replaceKeyWord(htmltext, "{" );
        htmltext = replaceKeyWord(htmltext, "}" );
        htmltext = htmltext.replaceAll("../../", "" );
        htmltext = htmltext.replaceAll("*/", "" );
        htmltext = htmltext.replaceAll("/*", "" );
        _html.setPage(htmltext);
      }, subdir: "tut" );
  }
}

