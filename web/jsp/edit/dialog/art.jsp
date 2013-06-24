<%@ page contentType="text/html;charset=GBK" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=javascript src="dialog.js"></script>
<link href='dialog.css' type='text/css' rel='stylesheet'>

<script language=javascript>

var sAction = "INSERT";
var sTitle = "插入";
var sel = dialogArguments.eWebEditor.document.selection.createRange();
sel.type = dialogArguments.eWebEditor.document.selection.type;

var oControl;
var sText = "请在此键入您自己的内容";
var sFontFamily = "宋体";
var sFontSize = "36";
var sFontUnit = "pt"
var sFontWeight = "normal";
var sFontStyle = "normal";
var sShapeID = "shape_x0000_i0001";

if (sel.type=="Control") {
	oControl = sel.item(0);
	if (oControl.tagName=="shape"){
		if (oControl.textpath.string){
			sAction = "MODI";
			sTitle = "修改";

			var oTextPath = oControl.all.tags("textpath")(0);
			sFontFamily = oTextPath.style.fontFamily;
			sFontSize = oTextPath.style.fontSize;
			if (sFontSize.substr(sFontSize.length-2)=="px"){
				sFontUnit = "px";
			}
			sFontSize = parseInt(sFontSize);
			if (isNaN(sFontSize)) {sFontSize = "36"}

			sFontWeight = oTextPath.style.fontWeight;
			sFontWeight = sFontWeight.toLowerCase();
			if (sFontWeight!="bold") {sFontWeight="normal"}

			sFontStyle = oTextPath.style.fontStyle;
			sFontStyle = sFontStyle.toLowerCase();
			if (sFontStyle!="italic") {sFontStyle="normal"}

			sText = oTextPath.string;
			sShapeID = "shape"+oControl.getAttribute("myid");
			if (sShapeID=="") {sShapeID="shape_x0000_i0001"}
		}
	}
}

var aArts=new Array(
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0001 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t136" coordsize = "21600,21600"><v:shadow color = "#868686"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t172 coordsize = "21600,21600" o:spt = "172" path = " m0@0 l21600,0 m0,21600 l21600@1 e" adj = "12000"><v:formulas><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "sum 21600 0 @0 "></v:f><v:f eqn = "prod #0 1 2 "></v:f><v:f eqn = "sum @2 10800 0 "></v:f><v:f eqn = "prod @1 1 2 "></v:f><v:f eqn = "sum @4 10800 0 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="10800,@2;0,@3;10800,@5;21600,@4" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h position="topLeft,#0" yrange="0,15429"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0002 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t172" coordsize = "21600,21600" fillcolor = "black"><v:shadow color = "#868686"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t144 coordsize = "21600,21600" o:spt = "144" path = " al10800,10800,10800,10800@2@14 e" adj = "11796480"><v:formulas><v:f eqn = "sum #1 0 0 "></v:f><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "sum 0 0 #0 "></v:f><v:f eqn = "sumangle #0 0 180 "></v:f><v:f eqn = "sumangle #0 0 90 "></v:f><v:f eqn = "prod @4 2 1 "></v:f><v:f eqn = "sumangle #0 90 0 "></v:f><v:f eqn = "prod @6 2 1 "></v:f><v:f eqn = "abs #0 "></v:f><v:f eqn = "sumangle @8 0 90 "></v:f><v:f eqn = "if @9 @7 @5 "></v:f><v:f eqn = "sumangle @10 0 360 "></v:f><v:f eqn = "if @10 @11 @10 "></v:f><v:f eqn = "sumangle @12 0 360 "></v:f><v:f eqn = "if @12 @13 @12 "></v:f><v:f eqn = "sum 0 0 @14 "></v:f><v:f eqn = "sum 10800 0 0 "></v:f><v:f eqn = "cos 10800 #0 "></v:f><v:f eqn = "sin 10800 #0 "></v:f><v:f eqn = "sum @17 10800 0 "></v:f><v:f eqn = "sum @18 10800 0 "></v:f><v:f eqn = "sum 10800 0 @17 "></v:f><v:f eqn = "if @9 0 21600 "></v:f><v:f eqn = "sum 10800 0 @18 "></v:f></v:formulas><v:path o:connectlocs="10800,@22;@19,@20;@21,@20" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath style="v-text-kern: t" on = "t" fitpath = "t"></v:textpath><v:handles><v:h position="@16,#0" polar="10800,10800"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0003 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t144" coordsize = "21600,21600" fillcolor = "black"><v:shadow color = "#868686"></v:shadow><v:textpath style="FONT-SIZE: 12pt; fitshape = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t161 coordsize = "21600,21600" o:spt = "161" path = " m0,0 c7200@0,14400@0,21600,0 m0,21600 c7200@1,14400@1,21600,21600 e" adj = "4050"><v:formulas><v:f eqn = "prod #0 4 3 "></v:f><v:f eqn = "sum 21600 0 @0 "></v:f><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "sum 21600 0 #0 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="10800,@2;0,10800;10800,@3;21600,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t" xscale = "t"></v:textpath><v:handles><v:h position="center,#0" yrange="0,8100"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0004 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t161" coordsize = "21600,21600" fillcolor = "black" adj = "5665"><v:shadow color = "#868686"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" xscale = "f" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t175 coordsize = "21600,21600" o:spt = "175" path = " m0,0 qy10800@0,21600,0 m0@1 qy10800,21600,21600@1 e" adj = "3086"><v:formulas><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "sum 21600 0 #0 "></v:f><v:f eqn = "prod @1 1 2 "></v:f><v:f eqn = "sum @2 10800 0 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="10800,@0;0,@2;10800,21600;21600,@2" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h position="center,#0" yrange="0,7200"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0005 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t175" coordsize = "21600,21600" fillcolor = "black" adj = "7200"><v:shadow color = "#868686"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0006 style="WIDTH: 42pt; HEIGHT: 12pt; rotation: 90" type = "#_x0000_t136" coordsize = "21600,21600" fillcolor = "black"><v:shadow color = "#868686"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t; v-rotate-letters: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0007 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t136" coordsize = "21600,21600"><v:shadow on = "t" opacity = "52429f"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0008 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t136" coordsize = "21600,21600" fillcolor = "#369" stroked = "f"><v:shadow on = "t" color = "#b2b2b2" opacity = "52429f" offset = "3pt"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0009 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t136" coordsize = "21600,21600" fillcolor = "#b2b2b2" strokecolor = "#33c" strokeweight = "1pt"><v:fill opacity = ".5"></v:fill><v:shadow on = "t" color = "#99f" offset = "3pt"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0010 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t136" coordsize = "21600,21600" stroked = "f"><v:fill type = "gradient" color2 = "#aaa"></v:fill><v:shadow on = "t" color = "#4d4d4d" opacity = "52429f" offset = ",3pt"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t; v-text-spacing: 78650f" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0011 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t136" coordsize = "21600,21600" fillcolor = "#06c" strokecolor = "#9cf" strokeweight = "1.5pt"><v:shadow on = "t" color = "#900"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0012 style="WIDTH: 42pt; HEIGHT: 12pt; rotation: 90" type = "#_x0000_t136" coordsize = "21600,21600" fillcolor = "maroon" strokecolor = "maroon"><v:shadow on = "t" color = "#b2b2b2" opacity = "52429f"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t; v-rotate-letters: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0013 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t136" coordsize = "21600,21600" fillcolor = "yellow" stroked = "f"><v:fill type = "gradientCenter" color2 = "#f93" angle = "-135" focus = "100%" focusposition = ".5,.5" focussize = "0,0"><o:fill v:ext="view"></o:fill></v:fill><v:shadow on = "t" color = "silver" opacity = "52429f"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t172 coordsize = "21600,21600" o:spt = "172" path = " m0@0 l21600,0 m0,21600 l21600@1 e" adj = "12000"><v:formulas><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "sum 21600 0 @0 "></v:f><v:f eqn = "prod #0 1 2 "></v:f><v:f eqn = "sum @2 10800 0 "></v:f><v:f eqn = "prod @1 1 2 "></v:f><v:f eqn = "sum @4 10800 0 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="10800,@2;0,@3;10800,@5;21600,@4" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h position="topLeft,#0" yrange="0,15429"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0014 style="WIDTH: 42pt; HEIGHT: 27pt" type = "#_x0000_t172" coordsize = "21600,21600" fillcolor = "#60c" strokecolor = "#c9f" adj = "6924"><v:fill type = "gradient" color2 = "#c0c" focus = "100%"></v:fill><v:shadow on = "t" color = "#99f" opacity = "52429f" offset = "3pt,3pt"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0015 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t136" coordsize = "21600,21600" fillcolor = "#063" strokecolor = "green"><v:fill src = "../Images/clip_image001.jpg" type = "tile"></v:fill><v:shadow on = "t" type = "perspective" color = "#c7dfd3" opacity = "52429f" matrix = "1.25,,,1.25" origin = "-.5,-.5" offset = "-8pt,-12pt"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0016 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t136" coordsize = "21600,21600" fillcolor = "#9400ed" strokecolor = "#eaeaea" strokeweight = "1pt"><v:fill type = "gradient" color2 = "blue" angle = "-90" method = "none" colors = "0 #a603ab;13763f #0819fb;22938f #1a8d48;34079f yellow;47841f #ee3f17;57672f #e81766;1 #a603ab"></v:fill><v:shadow on = "t" type = "perspective" color = "silver" opacity = "52429f" matrix = ",46340f,,.5,0,-476837158203125e-21" origin = "-.5,.5"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t156 coordsize = "21600,21600" o:spt = "156" path = " m@25@0 c@26@3@27@1@28@0 m@21@4 c@22@5@23@6@24@4 e" adj = "2809,10800"><v:formulas><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "prod @0 41 9 "></v:f><v:f eqn = "prod @0 23 9 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 #0 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "sum #1 0 10800 "></v:f><v:f eqn = "sum 21600 0 #1 "></v:f><v:f eqn = "prod @8 2 3 "></v:f><v:f eqn = "prod @8 4 3 "></v:f><v:f eqn = "prod @8 2 1 "></v:f><v:f eqn = "sum 21600 0 @9 "></v:f><v:f eqn = "sum 21600 0 @10 "></v:f><v:f eqn = "sum 21600 0 @11 "></v:f><v:f eqn = "prod #1 2 3 "></v:f><v:f eqn = "prod #1 4 3 "></v:f><v:f eqn = "prod #1 2 1 "></v:f><v:f eqn = "sum 21600 0 @15 "></v:f><v:f eqn = "sum 21600 0 @16 "></v:f><v:f eqn = "sum 21600 0 @17 "></v:f><v:f eqn = "if @7 @14 0 "></v:f><v:f eqn = "if @7 @13 @15 "></v:f><v:f eqn = "if @7 @12 @16 "></v:f><v:f eqn = "if @7 21600 @17 "></v:f><v:f eqn = "if @7 0 @20 "></v:f><v:f eqn = "if @7 @9 @19 "></v:f><v:f eqn = "if @7 @10 @18 "></v:f><v:f eqn = "if @7 @11 21600 "></v:f><v:f eqn = "sum @24 0 @21 "></v:f><v:f eqn = "sum @4 0 @0 "></v:f><v:f eqn = "max @21 @25 "></v:f><v:f eqn = "min @24 @28 "></v:f><v:f eqn = "prod @0 2 1 "></v:f><v:f eqn = "sum 21600 0 @33 "></v:f><v:f eqn = "mid @26 @27 "></v:f><v:f eqn = "mid @24 @28 "></v:f><v:f eqn = "mid @22 @23 "></v:f><v:f eqn = "mid @21 @25 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@35,@0;@38,10800;@37,@4;@36,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t" xscale = "t"></v:textpath><v:handles><v:h position="topLeft,#0" yrange="0,4459"></v:h><v:h xrange="8640,12960" position="#1,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0017 style="WIDTH: 42pt; HEIGHT: 16.5pt" type = "#_x0000_t156" coordsize = "21600,21600" fillcolor = "#99f" stroked = "f"><v:fill type = "gradient" color2 = "#099" focus = "100%"></v:fill><v:shadow on = "t" color = "silver" opacity = "52429f" offset = "3pt,3pt"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" xscale = "f" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0018 style="WIDTH: 42pt; HEIGHT: 12pt; rotation: 90" type = "#_x0000_t136" coordsize = "21600,21600" fillcolor = "#c4b596" strokecolor = "#c4b596" strokeweight = "1pt"><v:fill src = "../Images/clip_image001.jpg" type = "tile"></v:fill><v:shadow on = "t" color = "#cbcbcb" opacity = "52429f" offset = "3pt,3pt"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t; v-rotate-letters: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"> <v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0019 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t136" coordsize = "21600,21600" fillcolor = "#fc9"><v:fill src = "../Images/clip_image001.jpg" type = "tile"></v:fill><v:shadow color = "#868686"></v:shadow><o:extrusion v:ext="view" on = "t" skewangle = "180" backdepth = "10pt" color = "#630" brightness = "4000f" lightlevel = "52000f" lightlevel2 = "14000f" lightharsh2 = "t" viewpointorigin = ",0" viewpoint = ",0" lightposition = "-50000" lightposition2 = "50000"></o:extrusion><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t138 coordsize = "21600,21600" o:spt = "138" path = " m0@0 l10800,0,21600@0 m0,21600 l10800,21600,21600,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "prod #0 1 2 "></v:f><v:f eqn = "sum @1 10800 0 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="10800,0;5400,@1;10800,21600;16200,@1" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h position="topLeft,#0" yrange="0,21600"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0020 style="WIDTH: 42pt; HEIGHT: 15.75pt" type = "#_x0000_t138" coordsize = "21600,21600" fillcolor = "#ffc"><v:fill type = "gradient" color2 = "#f99" focus = "100%"></v:fill><v:shadow color = "#868686"></v:shadow><o:extrusion v:ext="view" on = "t" skewangle = "-45" backdepth = "18pt" color = "#06c" brightness = "10000f" lightlevel = "44000f" lightlevel2 = "24000f" viewpointorigin = "-.5" viewpoint = "-1249999emu" lightposition = "0,-50000" lightposition2 = "0,50000"></o:extrusion><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t170 coordsize = "21600,21600" o:spt = "170" path = " m@0,0 l@1,0 m0,21600 l21600,21600 e" adj = "7200"><v:formulas><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "sum 21600 0 @0 "></v:f><v:f eqn = "prod #0 1 2 "></v:f><v:f eqn = "sum 21600 0 @2 "></v:f><v:f eqn = "sum @1 21600 @0 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="10800,0;@2,10800;10800,21600;@3,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="0,10792" position="#0,topLeft"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0021 style="WIDTH: 23.25pt; HEIGHT: 12pt" type = "#_x0000_t170" coordsize = "21600,21600" fillcolor = "#520402" strokecolor = "#b2b2b2" strokeweight = "1pt" adj = "2158"><v:fill type = "gradient" color2 = "#fc0" focus = "100%"></v:fill><v:shadow on = "t" type = "perspective" color = "#875b0d" opacity = "45875f" matrix = ",,,.5,0,-476837158203125e-21" origin = ",.5"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t152 coordsize = "21600,21600" o:spt = "152" path = " m0@0 c7200@2,14400@1,21600,0 m0@5 c7200@6,14400@6,21600@5 e" adj = "9931"><v:formulas><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "prod #0 3 4 "></v:f><v:f eqn = "prod #0 5 4 "></v:f><v:f eqn = "prod #0 3 8 "></v:f><v:f eqn = "prod #0 1 8 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "sum @4 21600 0 "></v:f><v:f eqn = "prod #0 1 2 "></v:f><v:f eqn = "prod @5 1 2 "></v:f><v:f eqn = "sum @7 @8 0 "></v:f><v:f eqn = "prod #0 7 8 "></v:f><v:f eqn = "prod @5 1 3 "></v:f><v:f eqn = "sum @1 @2 0 "></v:f><v:f eqn = "sum @12 @0 0 "></v:f><v:f eqn = "prod @13 1 4 "></v:f><v:f eqn = "sum @11 14400 @14 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="10800,@10;0,@9;10800,21600;21600,@8" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t" xscale = "t"></v:textpath><v:handles><v:h position="topLeft,#0" yrange="0,12169"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0022 style="WIDTH: 42pt; HEIGHT: 20.25pt" type = "#_x0000_t152" coordsize = "21600,21600" fillcolor = "gray" strokeweight = "1pt" adj = "8717"><v:fill src = "../Images/clip_image001.gif" type = "pattern" color2 = "yellow"></v:fill><v:shadow on = "t" opacity = "52429f" offset = "3pt"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" xscale = "f" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t152 coordsize = "21600,21600" o:spt = "152" path = " m0@0 c7200@2,14400@1,21600,0 m0@5 c7200@6,14400@6,21600@5 e" adj = "9931">&nbsp;<v:formulas><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "prod #0 3 4 "></v:f><v:f eqn = "prod #0 5 4 "></v:f><v:f eqn = "prod #0 3 8 "></v:f><v:f eqn = "prod #0 1 8 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "sum @4 21600 0 "></v:f><v:f eqn = "prod #0 1 2 "></v:f><v:f eqn = "prod @5 1 2 "></v:f><v:f eqn = "sum @7 @8 0 "></v:f><v:f eqn = "prod #0 7 8 "></v:f><v:f eqn = "prod @5 1 3 "></v:f><v:f eqn = "sum @1 @2 0 "></v:f><v:f eqn = "sum @12 @0 0 "></v:f><v:f eqn = "prod @13 1 4 "></v:f><v:f eqn = "sum @11 14400 @14 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="10800,@10;0,@9;10800,21600;21600,@8" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t" xscale = "t"></v:textpath><v:handles><v:h position="topLeft,#0" yrange="0,12169"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0023 style="WIDTH: 42pt; HEIGHT: 18.75pt" type = "#_x0000_t152" coordsize = "21600,21600" fillcolor = "gray" strokeweight = "1pt" adj = "8717"><v:fill src = "../Images/clip_image001.gif" type = "pattern" color2 = "yellow"></v:fill><v:shadow on = "t" opacity = "52429f" offset = "3pt"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" xscale = "f" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t159 coordsize = "21600,21600" o:spt = "159" path = " m@37@0 c@38@1@39@3@40@0@41@1@42@3@43@0 m@30@4 c@31@6@32@5@33@4@34@6@35@5@36@4 e" adj = "1404,10800"><v:formulas><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "prod @0 41 9 "></v:f><v:f eqn = "prod @0 23 9 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 #0 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "sum #1 0 10800 "></v:f><v:f eqn = "sum 21600 0 #1 "></v:f><v:f eqn = "prod @8 1 3 "></v:f><v:f eqn = "prod @8 2 3 "></v:f><v:f eqn = "prod @8 4 3 "></v:f><v:f eqn = "prod @8 5 3 "></v:f><v:f eqn = "prod @8 2 1 "></v:f><v:f eqn = "sum 21600 0 @9 "></v:f><v:f eqn = "sum 21600 0 @10 "></v:f><v:f eqn = "sum 21600 0 @8 "></v:f><v:f eqn = "sum 21600 0 @11 "></v:f><v:f eqn = "sum 21600 0 @12 "></v:f><v:f eqn = "sum 21600 0 @13 "></v:f><v:f eqn = "prod #1 1 3 "></v:f><v:f eqn = "prod #1 2 3 "></v:f><v:f eqn = "prod #1 4 3 "></v:f><v:f eqn = "prod #1 5 3 "></v:f><v:f eqn = "prod #1 2 1 "></v:f><v:f eqn = "sum 21600 0 @20 "></v:f><v:f eqn = "sum 21600 0 @21 "></v:f><v:f eqn = "sum 21600 0 @22 "></v:f><v:f eqn = "sum 21600 0 @23 "></v:f><v:f eqn = "sum 21600 0 @24 "></v:f><v:f eqn = "if @7 @19 0 "></v:f><v:f eqn = "if @7 @18 @20 "></v:f><v:f eqn = "if @7 @17 @21 "></v:f><v:f eqn = "if @7 @16 #1 "></v:f><v:f eqn = "if @7 @15 @22 "></v:f><v:f eqn = "if @7 @14 @23 "></v:f><v:f eqn = "if @7 21600 @24 "></v:f><v:f eqn = "if @7 0 @29 "></v:f><v:f eqn = "if @7 @9 @28 "></v:f><v:f eqn = "if @7 @10 @27 "></v:f><v:f eqn = "if @7 @8 @8 "></v:f><v:f eqn = "if @7 @11 @26 "></v:f><v:f eqn = "if @7 @12 @25 "></v:f><v:f eqn = "if @7 @13 21600 "></v:f><v:f eqn = "sum @36 0 @30 "></v:f><v:f eqn = "sum @4 0 @0 "></v:f><v:f eqn = "max @30 @37 "></v:f><v:f eqn = "min @36 @43 "></v:f><v:f eqn = "prod @0 2 1 "></v:f><v:f eqn = "sum 21600 0 @48 "></v:f><v:f eqn = "mid @36 @43 "></v:f><v:f eqn = "mid @30 @37 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@40,@0;@51,10800;@33,@4;@50,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t" xscale = "t"></v:textpath><v:handles><v:h position="topLeft,#0" yrange="0,2229"></v:h><v:h xrange="8640,12960" position="#1,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0024 style="WIDTH: 42pt; HEIGHT: 16.5pt; rotation: 90" type = "#_x0000_t159" coordsize = "21600,21600" fillcolor = "lime" stroked = "f" adj = "2809"><v:fill type = "gradient" color2 = "#0cf" focus = "100%"></v:fill><v:shadow on = "t" color = "navy" opacity = "52429f" offset = "-5pt,6pt"></v:shadow><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t; v-rotate-letters: t" fitpath = "t" trim = "t" xscale = "f" string = "WordArt"></v:textpath><v:handles><v:h position="topLeft,#0" yrange="0,4459"></v:h><v:h xrange="8640,12960" position="#1,bottomRight"></v:h></v:handles></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0025 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t136" coordsize = "21600,21600"><v:fill type = "gradient" focus = "100%" method = "none" colors = "0 #cbcbcb;8520f #5f5f5f;13763f #5f5f5f;41288f white;43909f #b2b2b2;45220f #292929;53740f #777;1 #eaeaea"></v:fill><v:shadow color = "#868686"></v:shadow><o:extrusion v:ext="view" on = "t" type = "perspective" skewangle = "-45" backdepth = "18pt" color = "white" specularity = "80000f" diffusity = "43712f" metal = "t" brightness = "10000f" lightlevel = "44000f" lightlevel2 = "24000f" viewpointorigin = "-.5" viewpoint = "-1249999emu" lightposition = "0,-50000" lightposition2 = "0,50000"></o:extrusion><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t154 coordsize = "21600,21600" o:spt = "154" path = " m0@2 l21600,0 m0,21600 l21600@0 e" adj = "9600"><v:formulas><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "sum 21600 0 #0 "></v:f><v:f eqn = "prod @1 1 4 "></v:f><v:f eqn = "prod #0 1 2 "></v:f><v:f eqn = "prod @2 1 2 "></v:f><v:f eqn = "sum @3 10800 0 "></v:f><v:f eqn = "sum @4 10800 0 "></v:f><v:f eqn = "sum @0 21600 @2 "></v:f><v:f eqn = "prod @7 1 2 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="10800,@4;0,@6;10800,@5;21600,@3" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h position="bottomRight,#0" yrange="6171,21600"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0026 style="WIDTH: 42pt; HEIGHT: 18.75pt" type = "#_x0000_t154" coordsize = "21600,21600" fillcolor = "#060"><v:fill o:title="?" src = "../Images/clip_image001.jpg" type = "tile"></v:fill><v:shadow color = "#868686"></v:shadow><o:extrusion v:ext="view" on = "t" type = "perspective" skewangle = "-45" color = "#060" brightness = "4000f" lightlevel = "52000f" lightlevel2 = "14000f" lightharsh2 = "t" viewpointorigin = "-.5" viewpoint = "-1249999emu" rotationangle = ",-18" lightposition = "0,-50000" lightposition2 = "0,50000"></o:extrusion><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t163 coordsize = "21600,21600" o:spt = "163" path = " m0,0 l21600,0 m0,21600 c7200@1,14400@1,21600,21600 e" adj = "11475"><v:formulas><v:f eqn = "prod #0 4 3 "></v:f><v:f eqn = "sum @0 0 7200 "></v:f><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "prod #0 2 3 "></v:f><v:f eqn = "sum @3 7200 0 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="10800,0;0,10800;10800,@2;21600,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t" xscale = "t"></v:textpath><v:handles><v:h position="center,#0" yrange="1350,21600"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0027 style="WIDTH: 42pt; HEIGHT: 17.25pt" type = "#_x0000_t163" coordsize = "21600,21600" adj = "16518"><v:fill type = "gradient" color2 = "#707070" angle = "-135" focus = "50%"></v:fill><v:shadow color = "#868686"></v:shadow><o:extrusion v:ext="view" on = "t" type = "perspective" skewangle = "0" skewamt = "0%" backdepth = "30pt" color = "#939676" brightness = "10000f" lightlevel = "44000f" lightlevel2 = "24000f" viewpointorigin = "0,0" viewpoint = "0,0" rotationangle = "30,-36" lightposition = "-50000,-50000" lightposition2 = "50000"></o:extrusion><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" xscale = "f" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t154 coordsize = "21600,21600" o:spt = "154" path = " m0@2 l21600,0 m0,21600 l21600@0 e" adj = "9600"><v:formulas><v:f eqn = "sum #0 0 0 "></v:f><v:f eqn = "sum 21600 0 #0 "></v:f><v:f eqn = "prod @1 1 4 "></v:f><v:f eqn = "prod #0 1 2 "></v:f><v:f eqn = "prod @2 1 2 "></v:f><v:f eqn = "sum @3 10800 0 "></v:f><v:f eqn = "sum @4 10800 0 "></v:f><v:f eqn = "sum @0 21600 @2 "></v:f><v:f eqn = "prod @7 1 2 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="10800,@4;0,@6;10800,@5;21600,@3" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h position="bottomRight,#0" yrange="6171,21600"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0028 style="WIDTH: 42pt; HEIGHT: 18.75pt" type = "#_x0000_t154" coordsize = "21600,21600" fillcolor = "#ffe701"><v:fill type = "gradient" color2 = "#fe3e02" focus = "100%" focusposition = "1,1" focussize = "0,0"></v:fill><v:shadow color = "#868686"></v:shadow><o:extrusion v:ext="view" on = "t" type = "perspective" skewangle = "0" skewamt = "0%" color = "#f60" brightness = "4000f" lightlevel = "52000f" lightlevel2 = "14000f" lightharsh2 = "t" viewpointorigin = "0,0" viewpoint = "0,0" rotationangle = "18,18" lightposition = ",50000"></o:extrusion><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0029 style="WIDTH: 42pt; HEIGHT: 12pt" type = "#_x0000_t136" coordsize = "21600,21600" fillcolor = "#dcebf5"><v:fill type = "gradient" color2 = "#55261c" focus = "100%" method = "none" colors = "0 #dcebf5;5243f #83a7c3;8520f #768fb9;13763f #83a7c3;34079f white;36700f #9c6563;38011f #80302d;46531f #c0524e;61604f #ebdad4;1 #55261c"></v:fill><v:shadow color = "#868686"></v:shadow><o:extrusion v:ext="view" on = "t" type = "perspective" skewangle = "135" color = "silver" brightness = "4000f" lightlevel = "52000f" lightlevel2 = "14000f" lightharsh2 = "t" viewpointorigin = ",.5" viewpoint = ",1249999emu" rotationangle = ",-6" lightposition = "0,50000" lightposition2 = "0,-50000"></o:extrusion><v:textpath style="FONT-SIZE: 12pt; v-text-kern: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>',
	'<v:shapetype id=_x0000_t136 coordsize = "21600,21600" o:spt = "136" path = " m@7,0 l@8,0 m@5,21600 l@6,21600 e" adj = "10800"><v:formulas><v:f eqn = "sum #0 0 10800 "></v:f><v:f eqn = "prod #0 2 1 "></v:f><v:f eqn = "sum 21600 0 @1 "></v:f><v:f eqn = "sum 0 0 @2 "></v:f><v:f eqn = "sum 21600 0 @3 "></v:f><v:f eqn = "if @0 @3 0 "></v:f><v:f eqn = "if @0 21600 @1 "></v:f><v:f eqn = "if @0 0 @2 "></v:f><v:f eqn = "if @0 @4 21600 "></v:f><v:f eqn = "mid @5 @6 "></v:f><v:f eqn = "mid @8 @5 "></v:f><v:f eqn = "mid @7 @8 "></v:f><v:f eqn = "mid @6 @7 "></v:f><v:f eqn = "sum @6 0 @5 "></v:f></v:formulas><v:path o:connectangles="270,180,90,0" o:connectlocs="@9,0;@10,10800;@11,21600;@12,10800" textpathok = "t" o:connecttype = "custom"></v:path><v:textpath on = "t" fitshape = "t"></v:textpath><v:handles><v:h xrange="6629,14971" position="#0,bottomRight"></v:h></v:handles><o:lock shapetype="t" text="t" v:ext="edit"></o:lock></v:shapetype><v:shape myid=_x0000_i0030 style="WIDTH: 42pt; HEIGHT: 12pt; rotation: 90" type = "#_x0000_t136" coordsize = "21600,21600" fillcolor = "#c00"><v:shadow color = "#868686"></v:shadow><o:extrusion v:ext="view" on = "t" type = "perspective" skewangle = "0" skewamt = "0%" backdepth = "18pt" color = "#f96" specularity = "80000f" brightness = "10000f" lightlevel = "44000f" lightlevel2 = "24000f" viewpointorigin = "0,0" viewpoint = "0,0" rotationangle = "16,-15" lightposition = "0,50000" lightposition2 = "0,-50000"></o:extrusion><v:textpath style="FONT-SIZE: 12pt;v-text-kern: t; v-rotate-letters: t" fitpath = "t" trim = "t" string = "WordArt"></v:textpath></v:shape>'
);

document.write("<title>艺术字(" + sTitle + ")</title>");

function check(){
	sBehavior = event.srcElement.value;
}

function InitDocument() {
	var str = "<table border=0 cellpadding=0 cellspacing=3>";
	for (var i=0; i<aArts.length; i++){
		if (i%6==0){
			str += "<tr valign=middle align=center height=75>";
		}
		var s = i + 1;
		if (s<10){
			s = "0" + s;
		}
		str += "<td id='shape_x0000_i00" + s + "' onmouseover='doMouseOver(this)' onmouseout='doMouseOut(this)' onclick='doClick(this)' class='shapenormal'><div style='width:75px' id='shape_x0000_i00" + s + "_div'><span>" + aArts[i] + "</span></div></td>";
		if (i%6==5){
			str += "</tr>";
		}
	}
	str += "</table>"
	td_shape.innerHTML = str;
	try{
		document.all(sShapeID).click();
	}catch(e){}

	td_fontfamily.innerHTML = "<select id=d_fontfamily onchange='doFontFamily(this.options[this.selectedIndex].value)'><option selected>字体</option><option value='宋体'>宋体</option><option value='黑体'>黑体</option><option value='楷体_GB2312'>楷体</option><option value='仿宋_GB2312'>仿宋</option><option value='隶书'>隶书</option><option value='幼圆'>幼圆</option><option value='Arial'>Arial</option><option value='Arial Black'>Arial Black</option><option value='Arial Narrow'>Arial Narrow</option><option value='Brush Script MT'>Brush Script MT</option><option value='Century Gothic'>Century Gothic</option><option value='Comic Sans MS'>Comic Sans MS</option><option value='Courier'>Courier</option><option value='Courier New'>Courier New</option><option value='MS Sans Serif'>MS Sans Serif</option><option value='Script'>Script</option><option value='System'>System</option><option value='Times New Roman'>Times New Roman</option><option value='Verdana'>Verdana</option><option value='Wide Latin'>Wide Latin</option><option value='Wingdings'>Wingdings</option></select>";
	SearchSelectValue(d_fontfamily, sFontFamily);

	str = "<img onclick='doBold(this)' border=0 width=20 height=20 src='../buttonimage/" + config.ButtonDir + "/bold.gif' id=s_bold class="
	if (sFontWeight.toLowerCase()=="bold"){
		str += "imageselected";
	}else{
		str += "imagenormal";
	}
	str += ">";
	td_bold.innerHTML = str;

	str = "<img onclick='doItalic(this)' border=0 width=20 height=20 src='../buttonimage/" + config.ButtonDir + "/italic.gif' id=s_italic class="
	if (sFontStyle.toLowerCase()=="italic"){
		str += "imageselected";
	}else{
		str += "imagenormal";
	}
	str += ">";
	td_italic.innerHTML = str;

	d_fontsize.value = sFontSize;
	SearchSelectValue(d_fontunit, sFontUnit);

	changeTextStyle();
	d_text.value = sText;
	d_text.select();
	d_text.focus();

	adjustDialog();
}

function doMouseOver(obj){
	obj.className = "shapeselected";
}

function doMouseOut(obj){
	if (obj.id!=sShapeID){
		obj.className = "shapenormal";
	}
}

function doClick(obj){
	document.all(sShapeID).className = "shapenormal";
	obj.className = "shapeselected";
	sShapeID = obj.id;
}

function doBold(obj){
	if (obj.className=="imagenormal"){
		obj.className = "imageselected";
		sFontWeight = "bold";
	}else{
		obj.className = "imagenormal";
		sFontWeight = "normal";
	}
	changeTextStyle();
}

function doItalic(obj){
	if (obj.className=="imagenormal"){
		obj.className = "imageselected";
		sFontStyle = "italic";
	}else{
		obj.className = "imagenormal";
		sFontStyle = "normal";
	}
	changeTextStyle();
}

function changeTextStyle(){
	d_text.style.fontFamily = sFontFamily;
	d_text.style.fontSize = sFontSize + sFontUnit;
	d_text.style.fontWeight = sFontWeight;
	d_text.style.fontStyle = sFontStyle;
}

function doFontFamily(str){
	sFontFamily = str;
	changeTextStyle();
}

function doFontSize(obj){
	var str = obj.value;
	if (str.substring(0,1)=="0"){
		str = str.substr(1);
		obj.value = str;
	}
	if (str!=""){
		sFontSize = str;
		changeTextStyle();
	}
}

function doCheckNum(event){
	var key = event.keyCode;
	if (event.shiftKey){
		if ((key>=35)&&(key<=40)){
			return true;
		}else{
			return false;
		}
	}
	if ((key==35)||(key==36)||(key==37)||(key==38)||(key==39)||(key==40)||(key==8)||(key==46)){
		return true;
	}
	if ((key<=57)&&(key>=48)){
		return true;
	}
	return false;
}

function doFontUnit(str){
	sFontUnit = str;
	changeTextStyle();
}

function ok(){
	sText = BaseTrim(d_text.value);
	if (sText=="") {
		BaseAlert(d_text, "文字内容不允许为空！");
		return;
	}

	if (sShapeID=="") {sShapeID="shape_x0000_i0001"}
	if (sFontFamily=="") {sFontFamily="宋体"}
	if ((sFontSize=="")||(sFontSize=="0")) {sFontSize="36"}

	var aRow=sText.split(/\r\n/g);
	var nMaxLen=0;
	var nRow=aRow.length;
	for(var i=0; i<nRow; i++){
		var sRow=aRow[i];
		var n=0;
		for(var j=0; j<sRow.length; j++){
			var nCode=sRow.charCodeAt(j);
			if(nCode>128) n++;
			else n+=0.5;
		}
		if(n>nMaxLen)nMaxLen=n;
	}
	var sShapeWidth=(nMaxLen*parseFloat(sFontSize)) + sFontUnit;
	var sShapeHeight=(nRow*parseFloat(sFontSize)) + sFontUnit;

	hiddenPreview.innerHTML = document.all(sShapeID+"_div").innerHTML;
	var objShape = hiddenPreview.all.tags("shape")(0);
	objShape.style.width = sShapeWidth;
	objShape.style.height = sShapeHeight;
	var objTextPath = objShape.all.tags("textpath")(0);
	objTextPath.style.fontFamily = sFontFamily;
	objTextPath.style.fontSize = sFontSize + sFontUnit;
	objTextPath.style.fontWeight = sFontWeight;
	objTextPath.style.fontStyle = sFontStyle;
	objTextPath.string = sText;
	var sType = objShape.type.substr(1);
	var sOut = hiddenPreview.innerHTML;

	dialogArguments.insertHTML("");
	sel = dialogArguments.eWebEditor.document.selection.createRange();
	var obj;
	if (sel.type!="Control"){
		obj=sel.parentElement();
		if (obj.tagName=="lock"){
			obj=obj.parentElement;
			if (obj.tagName=="shapetype"){
				obj.removeNode(true);
			}
		}
	}
	var loop = true;
	while(loop){
		loop = false;
		sel = dialogArguments.eWebEditor.document.selection.createRange();
		if (sel.type!="Control"){
			obj=sel.parentElement();
			if (obj.tagName=="SPAN"){
				if (obj.innerHTML==""){
					obj.removeNode(true);
					loop = true;
				}
			}
		}
	}

	dialogArguments.insertHTML(sOut);
	

	var sStyleVML = "<p>&nbsp;</p>\n"
			+"<STYLE id=eWebEditor_Style_VML>\n"
			+"v\\:* {behavior: url(#default#VML);}\n"
			+"o\\:* {behavior: url(#default#VML);}\n"
			+"w\\:* {behavior: url(#default#VML);}\n"
			+"x\\:* {behavior: url(#default#VML);}\n"
			+".shape{behavior: url(#default#VML);}\n"
			+"</STYLE>\n";

	var oTempElements = dialogArguments.eWebEditor.document.getElementsByName("eWebEditor_Style_VML");
	if (oTempElements.length<=0){
		dialogArguments.setHTML(sStyleVML + dialogArguments.getHTML(), true);
	}else{
		for(var i=1; i<oTempElements.length; i++){
			var oTempElement = oTempElements(i);
			oTempElement.removeNode(true);
		}
	}

	window.returnValue = null;
	window.close();

}


</script>

<style>
.shapenormal {background-color:#FFFFFF;border:1px inset }
.shapeselected {background-color:#FFFFFF;border:1px solid #0000ff}
.imagenormal {cursor:hand;border-top:1px solid #FFFFFF;border-left:1px solid #FFFFFF;border-right:1px solid #333333;border-bottom:1px solid #333333;}
.imageselected {cursor:hand;background-color:#FFFFFF;border-top:1px solid #333333;border-left:1px solid #333333;border-right:1px solid #ffffff;border-bottom:1px solid #ffffff;}
v\:* {behavior: url(#default#VML);}
o\:* {behavior: url(#default#VML);}
.shape{behavior: url(#default#VML);}
</style>
<XML:NAMESPACE NS="urn:schemas-microsoft-com:vml" PREFIX="v"/>
</style>

</HEAD>

<body onload="InitDocument()">
<table border=0 cellpadding=0 cellspacing=5 id=tabDialogSize><tr><td>


<table border=0 cellpadding=0 cellspacing=0 align=center>
<tr valign=top align=center>
	<td width=483 id=td_shape rowspan=2></td>
	<td width=257>

		<table border=0 cellspacing=2 cellpadding=0 width="100%">
		<tr>
			<td>字体:</td>
			<td>大小:</td>
			<td colspan=2></td>
		</tr>
		<tr>
			<td id=td_fontfamily></td>
			<td><input type=text id=d_fontsize size=3 onkeyup="doFontSize(this)" onkeydown="return doCheckNum(event)"><select id=d_fontunit size=1 onchange="doFontUnit(this.options[this.selectedIndex].value)"><option value="pt">pt</option><option value="px">px</option></select></td>
			<td id=td_bold></td>
			<td id=td_italic></td>
		</tr>
		<tr>
			<td colspan=4>文字:</td>
		</tr>
		<tr>
			<td colspan=4 height="100%"><textarea id=d_text cols=5 rows=5 style="width:100%;height:280px"></textarea></td>
		</tr>
		</table>

	</td>
</tr>
<tr>
	<td valign=bottom align=right><input type=submit value='确定' id=Ok onclick="ok()">&nbsp;&nbsp;<input type=button value='取消' onclick="window.close();"></td>
</tr>
</table>



</td></tr></table>

<div id=hiddenPreview style="display:none"></div>

</body>
</html>
