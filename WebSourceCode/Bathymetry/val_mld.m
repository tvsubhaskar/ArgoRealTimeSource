% VAL_MLD:  Sub-menu for difference map plot, in Validate program 
%
%  Copyright     Jeff Dunn, CSIRO Marine Research March 2003
% 
% USAGE:  not user callable - invoked only by "validate" GUI

function val_mld

global mldh

mldh = figure('Units','points', ...
      'Color',[0.7 0.7 0.7], ...
      'MenuBar','none', ...
      'PaperType','a4letter', ...
      'Name','MLD calc', ... 
      'NumberTitle','off', ...
      'Position',[300 300 170 410]);

col = [0.8 0.2 0];

b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'Position',[5 365 160 40], ...
      'Fontsize',10, ...
      'String','Comparisons plotted when MLD calculated for both datasets', ...
      'Style','text');
b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'ForegroundColor',col, ...
      'Position',[5 320 60 20], ...
      'Fontsize',12, ...
      'String','Dataset', ...
      'Style','text');
b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'BackgroundColor',[1 1 1], ...
      'ForegroundColor',col, ...
      'Callback','val_util(''mld_dset'')', ...
      'FontSize',10, ...
      'Position',[70 320 80 40], ...
      'Value',1, ...
      'Tag','mld_dset', ...
      'Style','listbox');

b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'ForegroundColor',col, ...
      'Position',[5 285 100 20], ...
      'String','del T', ...
      'Style','text');
b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'BackgroundColor',[1 1 1], ...
      'ForegroundColor',col, ...
      'Callback','val_util(''mld_t'')', ...
      'FontSize',10, ...
      'Position',[90 290 60 20], ...
      'Tag','mld_delt', ...
      'String','', ...
      'Style','edit');

b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'ForegroundColor',col, ...
      'Position',[5 255 100 20], ...
      'String','del S', ...
      'Style','text');
b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'BackgroundColor',[1 1 1], ...
      'ForegroundColor',col, ...
      'Callback','val_util(''mld_s'')', ...
      'FontSize',10, ...
      'Position',[90 260 60 20], ...
      'Tag','mld_dels', ...
      'String','', ...
      'Style','edit');

b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'ForegroundColor',col, ...
      'Position',[5 225 100 20], ...
      'String','dSigma/dz', ...
      'Style','text');
b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'BackgroundColor',[1 1 1], ...
      'ForegroundColor',col, ...
      'Callback','val_util(''mld_sigdz'')', ...
      'FontSize',10, ...
      'Position',[90 230 60 20], ...
      'Tag','mld_sigdz', ...
      'String','', ...
      'Style','edit');

b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'ForegroundColor',col, ...
      'Position',[5 195 100 20], ...
      'String','del Sigma', ...
      'Style','text');
b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'BackgroundColor',[1 1 1], ...
      'ForegroundColor',col, ...
      'Callback','val_util(''mld_sig'')', ...
      'FontSize',10, ...
      'Position',[90 200 60 20], ...
      'Tag','mld_sig', ...
      'String','', ...
      'Style','edit');

b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'ForegroundColor',col, ...
      'FontSize',12, ...
      'Position',[5 160 160 20], ...
      'String','Estimate combination', ...
      'Style','text');
b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'BackgroundColor',[1 1 1], ...
      'ForegroundColor',col, ...
      'Callback','val_util(''mld_meth'')', ...
      'FontSize',10, ...
      'Position',[25 35 120 130], ...
      'Value',1, ...
      'Tag','mld_meth', ...
      'Style','listbox');

b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'BackgroundColor',col, ...
      'ForegroundColor',[0 0 0], ...
      'Callback','val_util(''calcmld'')', ...
      'FontSize',12, ...
      'Position',[5 5 100 20], ...
      'Tag','calcmld', ...
      'String','Calculate');

b = uicontrol('Parent',mldh, ...
      'Units','points', ...
      'Callback','val_util(''finishmld'')', ...
      'FontSize',10, ...
      'Position',[120 5 40 20], ...
      'String','Close');


val_util('initmld')

%---------------------------------------------------------------------------
