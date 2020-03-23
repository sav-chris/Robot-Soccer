% -----------------------------------------------------
%  (c) 2000-2004 Theodor Storm <theodor@tstorm.se>
%  http://www.tstorm.se
% -----------------------------------------------------

function res=kiks_tou(lic)
global KIKS_GUI_COLOR;
res={'' ,
    ' ======================= TERMS OF USE =======================' ,
    '  * KiKS is donationware and may be used for research,       ' ,
    '    teaching, and non-commercial use.' ,
    '' ,
    '  * You may not distribute modified or unmodified copies of' ,
    '    KiKS, not even in electronical form, without the written' ,
    '    permission of Theodor Storm <theodor@tstorm.se>.' ,
    '' ,
    '  * Removing or modifying this message, or the copyright' ,
    '    notices within the source code, is not permitted.' ,
    '' ,
    '  * The author is not responsible for any form of damage' , 
    '    caused by the use of this software.' ,
    ' ============================================================' ,
    '' ,
    '  Maintaining and developing KiKS costs time and money. If' ,
    '  you find KiKS useful, please support my work by donating' ,
    '  a sum of your choice to the PayPal account kiks@tstorm.se.' ,
    '  The donations will be used to purchase a Khepera II robot',
    '  and add-on turrets.' ,
    '' ,
    '  You can also send donations by mail to:' ,
    '  Theodor Storm, Djuloegatan 58, 64131 Katrineholm, Sweden.' ,
    '                          Thank you!' ,
    '' ,
    '   KiKS is (c) 2000-2004 Theodor Storm <theodor@tstorm.se>'};

h=figure('Visible','off',...
    'Color',KIKS_GUI_COLOR, ...
    'PaperUnits','points',...
    'Name','KiKS log history', ...
    'ToolBar','none', ...
    'CloseRequestFcn','', ...
    'Resize','off',...
    'ResizeFcn','p=get(gcf,''Position''); h=findobj(gcf,''tag'',''tou''); lp=get(h,''position''); lp(3:4)=p(3:4); set(h,''position'',lp);', ...
    'Menu','none', ...
    'WindowStyle','modal', ...
    'NumberTitle','off');
set(h,'Name','KiKS terms of use');
p=get(h,'Position');
xs=470;
ys=481;
p(1)=p(1)+(p(3)-xs)/2;
p(2)=p(2)+(p(4)-ys)/2;
p(3)=xs;
p(4)=ys;
set(h,'Position',p);

[rows,tmp]=size(res);

h1 = uicontrol('Parent',h, ...
    'BackgroundColor',[1 1 1], ...
    'Enable','on', ...
    'Units','pixels', ...
    'FontUnits','points', ...
    'FontName','Courier New', ...
    'FontSize',9, ...
    'FontWeight','normal', ...
    'HorizontalAlignment','left', ...
    'Position',[0 70 xs ys-70], ...
    'Style','listbox', ...
    'String',res,...
    'value',rows,...
    'Tag','tou');

h2 = uicontrol('Parent',h, ...
    'BackgroundColor',KIKS_GUI_COLOR, ...
    'Units','pixels', ...
    'Callback','delete(gcf);', ...
    'FontUnits','points', ...
    'FontName','Courier New', ...
    'Enable','off', ...
    'FontSize',9, ...
    'FontWeight','normal', ...
    'HorizontalAlignment','left', ...
    'Position',[5 5 200 30], ...
    'Style','pushbutton', ...
    'String','I agree, continue',...
    'Tag','tou_yes');

h3 = uicontrol('Parent',h, ...
    'BackgroundColor',KIKS_GUI_COLOR, ...
    'Units','pixels', ...
    'Callback','kiks_quit; delete(gcf);', ...
    'FontUnits','points', ...
    'FontName','Courier New', ...
    'Enable','off', ...
    'FontSize',9, ...
    'FontWeight','normal', ...
    'HorizontalAlignment','left', ...
    'Position',[xs-205 5 200 30], ...
    'Style','pushbutton', ...
    'String','No way, quit',...
    'Tag','tou_no');

h4 = uicontrol('Parent',h, ...
    'BackgroundColor',KIKS_GUI_COLOR, ...
    'Units','pixels', ...
    'Callback','v=get(gco,''Value''); yn=''off''; if(v==1) yn=''on''; end; h=findobj(gcf,''tag'',''tou_no''); set(h,''Enable'',yn); h=findobj(gcf,''tag'',''tou_yes''); set(h,''Enable'',yn);', ...
    'FontUnits','points', ...
    'FontName','Courier New', ...
    'Enable','on', ...
    'FontSize',9, ...
    'FontWeight','normal', ...
    'HorizontalAlignment','left', ...
    'Position',[60 40 400 30], ...
    'Style','checkbox', ...
    'String','I have read and understood the terms of use.',...
    'Tag','tou_understood');

set(h,'Visible','on');

uiwait(h);