//==============================================
//  MuseScore
//
//  Easy Jianpu plugin Ver1.0 for MuseScore Ver. 3.6.2
// 
//  Copyright (C)2021 Acow Li
//
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//==============================================

import QtQuick 2.9
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.3
import MuseScore 3.0
import Qt.labs.settings 1.0

MuseScore {
  menuPath: "Plugins.Easy Jianpu"
  version: "1.0"
  description: qsTr("Easy Jianpu")
  pluginType: "dialog"

  id: window
  width:285  // menu window size
  height:285

  ExclusiveGroup { id: exclusiveGroupKey }

  property var fontJianpu : "01SMN" // Font Name

  property var valCenterCInit : 60
  property var fontSizeInit : 13
  property var yPositionInit : 0
  property var xPositionInit : 0
  property var partListInit : 0
  property var colorListInit : 0


  property var fontName: [ "b,#","♭,♯" ]
  property var fontNameSel : 0
  property var itemX1 : 10
  property var itemX2 : 150
  property var itemY1 : 10
  property var itemDY : 25
  
  // RowLayout {  //======================  FONT
  //   id: row1
  //   x :itemX1
  //   y :itemY1+itemDY*0.5
  //   Label {
  //     text: "♭♯ Font"
  //   }
  // }

  // RowLayout {
  //   id: row1R
  //   x :itemX2
  //   y :itemY1+itemDY*0.5
  //   ComboBox {
  //     currentIndex: fontListInitNumber
  //     model: ListModel {
  //       id: fontList
  //       property var key
  //       ListElement { text: "b,#"; fName: 0 }
  //       ListElement { text: "♭,♯"; fName: 1 }
  //     }
  //     width: 100
  //     onCurrentIndexChanged: {
  //       fontList.key = fontList.get(currentIndex).fName
  //     }
  //   } // end ComboBox
  // }

  RowLayout {  //======================  CLEAR
    id: row1
    x : itemX2
    y : itemY1+itemDY*0.5
    Button {
      id: clearButton
      text: "Clear Text"
      onClicked: {
        clearText()
      }
    }
  }


  RowLayout {  //======================  FONT SIZE
    id: row2
    x :itemX1
    y :itemY1+itemDY*2
    Label {
//      font.pointSize: fontSizeMenu
      text: "Font Size"
    }
  }

  RowLayout {
    id: row2R
    x :itemX2
    y :itemY1+itemDY*2
    SpinBox {
      id: valFontSize
      implicitWidth: 55
      decimals: 0
      minimumValue: 4
      maximumValue: 36
      value: fontSizeInit
//      font.pointSize: fontSizeMenu
    }
  }


  RowLayout {  //======================  Y POSITION
    id: row3
    x :itemX1
    y :itemY1+itemDY*4
    Label {
//      font.pointSize: fontSizeMenu
      text: "Y position"
    }
  }

  RowLayout {
    id: row3R
    x :itemX2
    y :itemY1+itemDY*4
    SpinBox {
      id: valYPosition
      implicitWidth: 55
      decimals: 0
      minimumValue: -20
      maximumValue: 30
      value: yPositionInit
//      font.pointSize: fontSizeMenu
    }
  }


  
  RowLayout {  //======================  Jampu Notation Middle C MIDI note number
    id: rowJ
    x :itemX1
    y :itemY1+itemDY*3+5
    Label {
//      font.pointSize: fontSizeMenu
      text: "1 starts from (MIDI num)"
    }
  }

  RowLayout {
    id: rowJR
    x :itemX2
    y :itemY1+itemDY*3+5
    SpinBox {
      id: valCenterC
      implicitWidth: 55
      decimals: 0
      minimumValue: 0
      maximumValue: 127
      value: valCenterCInit
//      font.pointSize: fontSizeMenu
    }
  }



  
    
  RowLayout {  //======================  X POSITION
    id: row4
    x :itemX1
    y :itemY1+itemDY*4+40
    Label {
//      font.pointSize: fontSizeMenu
      text: "X position"
    }
  }

  RowLayout {
    id: row4R
    x :itemX2
    y :itemY1+itemDY*4+40
    SpinBox {
      id: valXPosition
      implicitWidth: 55
      decimals: 1
      minimumValue: -5
      maximumValue: 5
      value: xPositionInit
      stepSize: 0.1
//      font.pointSize: fontSizeMenu
    }
  }


  RowLayout {  //======================  PART
    id: row5
    x :itemX1
    y :itemY1+itemDY*5+40
    Label {
//      font.pointSize: fontSizeMenu
      text: "Part"
    }
  }

  RowLayout {
    id: row5R
    x :itemX2
    y :itemY1+itemDY*5+40
    ComboBox {
        currentIndex: partListInit
        model: ListModel {
        id: partList
        property var key
        ListElement { text: "Part 1"; pName: 0 }
        ListElement { text: "Part 2"; pName: 1 }
        ListElement { text: "Part 3"; pName: 2 }
        ListElement { text: "Part 4"; pName: 3 }
      }

      width: 60
      onCurrentIndexChanged: {
//console.debug(partList.get(currentIndex).text + ", " + partList.get(currentIndex).pName)
        partList.key = partList.get(currentIndex).pName
      }
    } // end ComboBox
  }


  RowLayout {  //======================  COLOR
    id: row6
    x :itemX1
    y :itemY1+itemDY*6+40
    Label {
//      font.pointSize: fontSizeMenu
      text: "Color"
    }
  }

  RowLayout {
    id: row6R
    x :itemX2
    y :itemY1+itemDY*6+40
    ComboBox {
      currentIndex: colorListInit
      model: ListModel {
        id: colorList
        property var key
        ListElement { text: "Black"; cName: 0 }
        ListElement { text: "Red"; cName: 1 }
        ListElement { text: "Blue"; cName: 2 }
        ListElement { text: "Green"; cName: 3 }
        ListElement { text: "Purple"; cName: 4 }
        ListElement { text: "Gray"; cName: 5 }
      }
      width: 60
      onCurrentIndexChanged: {
//console.debug(colorList.get(currentIndex).text + ", " + colorList.get(currentIndex).cName)
        colorList.key = colorList.get(currentIndex).cName
      }
    } // end ComboBox
  }

  RowLayout { //============ Ver. No. ================
  id: rowVerNo
    x : 10
    y : 260
    Label {
      font.pointSize: 10
      text: "V"+version
    }
    }

  RowLayout {  //======================  CANCEL  /  OK
    id: row7
    x : 110
    y : 250
    Button {
      id: closeButton
      text: "Cancel"
      onClicked: { Qt.quit() }
    }
    Button {
      id: okButton
      text: "Ok"
      onClicked: {
        apply()
        Qt.quit()
      }
    }
  }

  function apply() {
    curScore.startCmd()
    applyToSelection()
    curScore.endCmd()
  }

  function clearText() {
    curScore.startCmd()
    applyClearText()
    curScore.endCmd() 
  }

  onRun: {
    if (typeof curScore === 'undefined')
    Qt.quit();
  } // end onRun

  function applyToSelection() {

    var cursor = curScore.newCursor();
    var startStaff;
    var endStaff;
    var endTick;
    var fullScore = false;
    var yPos = valYPosition.value;
    var xPos = valXPosition.value;

    var fontSize = valFontSize.value;

    var fontSizeTag="<font size=\""+fontSize+"\"/>";
    var fontFaceTag="<font face=\""+fontJianpu+"\"/>";

    // RGB color  Black     , Red          , Blue         , Green       , Purple       , Gray
    var colorData = [ "#000000" ,"#FF0000" ,"#0000FF" ,"#00FF00" ,"#C007C0" ,"#888888" ];
    var fontColor = colorData[colorList.key];

    cursor.rewind(1);  // rewind to start of selection
    if (!cursor.segment) { // no selection
      fullScore = true;
      startStaff = 0; // start with 1st staff
      endStaff = curScore.nstaves - 1; // and end with last
    } else {
      startStaff = cursor.staffIdx;
      cursor.rewind(2); // rewind to end of selection
      if (cursor.tick == 0) {
        endTick = curScore.lastSegment.tick + 1;
      } else {
        endTick = cursor.tick;
      }
      endStaff = cursor.staffIdx;
    }
    console.log("staff start: "+startStaff+", end: "+endStaff);

    for (var staff = startStaff; staff <= endStaff; staff++) {
        var voice = partList.key;

        cursor.rewind(1); // beginning of selection
        cursor.voice    = voice;
        cursor.staffIdx = staff;

        if (fullScore)  // no selection
          cursor.rewind(0); // beginning of score

        while (cursor.segment && (fullScore || cursor.tick < endTick)) {
          var text = newElement(Element.STAFF_TEXT); // LYRICS
          text.placement = Placement.BELOW;
          text.autoplace = false;
          text.offsetX = xPos;
          text.offsetY = yPos + 4;
          text.color = fontColor;
          var duration = cursor.element.duration;
          // 音符
          if (cursor.element && cursor.element.type == Element.CHORD) {
            var notes = cursor.element.notes;
            createNotesText(duration, notes, text, fontSize);
          }
          // 休止符
          else {
            var zeroStr = "`"
            if (duration.denominator == 8) {
              zeroStr = "p"
            } else if (duration.denominator == 16) {
              zeroStr = ";"
            }
            text.text = fontSizeTag + fontFaceTag + zeroStr;
          }
          cursor.add(text);
          cursor.next();
        } // end while segment
    } // end for staff
  } // end applyToSelection

  function createNotesText(duration, notes, text, fontSize) {
    var fontSizeTag = "<font size=\""+fontSize+"\"/>";
    var fontFaceTag = "<font face=\""+fontJianpu+"\"/>";
    var type4_octaveP0  = ["1","2","2","3","3","4","5","5","6","6","7","7",
                           "1","1","2","2","3","4","4","5","5","6","6","7"]
    var type4_octaveP1  = ["!","@","@","#","#","$","%","%","^","^","&","&",
                           "!","!","@","@","#","$","$","%","%","^","^","&"]
    var type8_octaveP0  = ["q","w","w","e","e","r","t","t","y","y","u","u",
                           "q","q","w","w","e","r","r","t","t","y","y","u"]
    var type8_octaveP1  = ["Q","W","W","E","E","R","T","T","Y","Y","U","U",
                           "Q","Q","W","W","E","R","R","T","T","Y","Y","U"]
    var type16_octaveP0 = ["a","s","s","d","d","f","g","g","h","h","j","j",
                           "a","a","s","s","d","f","f","g","g","h","h","j"]
    var type16_octaveP1 = ["A","S","S","D","D","F","G","G","H","H","J","J",
                           "A","A","S","S","D","F","F","G","G","H","H","J"]
    var octaveP2Str = "~"
    var type4_octaveN1Str  = "8"
    var type4_octaveN2Str  = "*"
    var type8_octaveN1Str  = "i"
    var type8_octaveN2Str  = "I"
    var type16_octaveN1Str = "k"
    var type16_octaveN2Str = "K"
    var type4_dot  = "."
    var type8_dot  = "o"
    var type16_dot = "l"
    var long_dash = "/"
    var numerator = duration.numerator
    var denominator = duration.denominator
    var needDot = numerator == 3
    var specialDot2 = false
    if (needDot) {
      if (denominator >= 8) {
        denominator = denominator / 2;
      } else {
        specialDot2 = true
      }      
    }
    for (var i = 0; i < notes.length; i++) {
      var noteText = "";
      var pitchShift = valCenterC.value - 60;
      var octave = parseInt((notes[i].pitch - pitchShift) / 12) - 5;
      var pitchIndex = parseInt((notes[i].pitch - pitchShift) % 12);
      // console.log("time: "+numerator+"-"+denominator+", pitch: "+notes[i].pitch+", octave:"+octave+", pitchIndex:"+pitchIndex+", tpc: "+notes[i].tpc)
      var useSharp = false;
      if (notes[i].tpc>=6 && notes[i].tpc<=12) { // b Flat
        noteText = ":";
      } else if (notes[i].tpc>=20 && notes[i].tpc<=26) { // # Sharp
        noteText = "P";
        useSharp = true;
      }
      if (useSharp) {
        pitchIndex = pitchIndex + 12;
      }
      if (octave == -2) {
        if (denominator >= 16) {
          noteText = noteText + type16_octaveP0[pitchIndex] + type16_octaveN2Str;
        } else if (denominator == 8) {
          noteText = noteText + type8_octaveP0[pitchIndex] + type8_octaveN2Str;
        } else {
          noteText = noteText + type4_octaveP0[pitchIndex] + type4_octaveN2Str;
        }        
      } else if (octave == -1) {
        if (denominator >= 16) {
          noteText = noteText + type16_octaveP0[pitchIndex] + type16_octaveN1Str;
        } else if (denominator == 8) {
          noteText = noteText + type8_octaveP0[pitchIndex] + type8_octaveN1Str;
        } else {
          noteText = noteText + type4_octaveP0[pitchIndex] + type4_octaveN1Str;
        }
      } else if (octave == 1) {
        if (denominator >= 16) {
          noteText = noteText + type16_octaveP1[pitchIndex];
        } else if (denominator == 8) {
          noteText = noteText + type8_octaveP1[pitchIndex];
        } else {
          noteText = noteText + type4_octaveP1[pitchIndex];
        }
      } else if (octave == 2) {
        if (denominator >= 16) {
          noteText = noteText + type16_octaveP0[pitchIndex] + octaveP2Str;
        } else if (denominator == 8) {
          noteText = noteText + type8_octaveP0[pitchIndex] + octaveP2Str;
        } else {
          noteText = noteText + type4_octaveP0[pitchIndex] + octaveP2Str;
        }
      } else {
        if (denominator >= 16) {
          noteText = noteText + type16_octaveP0[pitchIndex];
        } else if (denominator == 8) {
          noteText = noteText + type8_octaveP0[pitchIndex];
        } else {
          noteText = noteText + type4_octaveP0[pitchIndex];
        }
      }
      if (needDot) {
        if (denominator >= 16) {
          noteText = noteText + type16_dot;
        } else if (denominator == 8) {
          noteText = noteText + type8_dot;
        } else if (denominator == 4) {
          if (specialDot2) {
            noteText = noteText + long_dash + long_dash;
          } else {
            noteText = noteText + type4_dot;
          }          
        }
      }
      if (denominator == 2) {
        noteText = noteText + long_dash;
      } else if (denominator == 1) {
        noteText = noteText + long_dash + long_dash + long_dash;
      }

      var sep = "\n";
      if (i > 0) text.text = text.text + sep + noteText;
      else text.text = noteText;

    } // end for note

    text.text = fontSizeTag + fontFaceTag + text.text;

  } // end createNotesText
  
  function applyClearText() {
    var cursor = curScore.newCursor();
    var startStaff;
    var endStaff;
    var endTick;
    var fullScore = false;
    cursor.rewind(1);  // rewind to start of selection
    if (!cursor.segment) { // no selection
      fullScore = true;
      startStaff = 0; // start with 1st staff
      endStaff = curScore.nstaves - 1; // and end with last
    } else {
      startStaff = cursor.staffIdx;
      cursor.rewind(2); // rewind to end of selection
      if (cursor.tick == 0) {
        endTick = curScore.lastSegment.tick + 1;
      } else {
        endTick = cursor.tick;
      }
      endStaff = cursor.staffIdx;
    }

    for (var staff = startStaff; staff <= endStaff; staff++) {
        var voice = partList.key;
        cursor.rewind(1); // beginning of selection
        cursor.voice    = voice;
        cursor.staffIdx = staff;
        if (fullScore)  // no selection
          cursor.rewind(0); // beginning of score

        while (cursor.segment && (fullScore || cursor.tick < endTick)) {
          for (var i = 0; i < cursor.segment.annotations.length; i++) {
            var annotation = cursor.segment.annotations[i]
            if (annotation.type === Element.STAFF_TEXT) {
              removeElement(annotation)
            }
          }
          cursor.next();
        }
    }
  }

} // end MuseScore
