% cullInitialMissions
%
% for floats where the mission is contained in the log files, the first
% mission must be obtained from the .000.log file which is not usually
% read.  You must ensure that htis file is in the iridium_processed
% directory.
%
% this script uses the data from cullMissions_iridium and only obtains the
% data from the 000 file.
%
% coded Feb 2014 : AT
%

global ARGO_SYS_PARAM
global ARGO_ID_CROSSREF
aic=ARGO_ID_CROSSREF;


kk=find(aic(:,1)==wmo_id);
fn= [ARGO_SYS_PARAM.root_dir 'matfiles/float' num2str(wmo_id) 'aux.mat']
if (aic(kk,2)<1000)
    fnm000=[ARGO_SYS_PARAM.root_dir 'iridium_data/iridium_processed/000files/0' num2str(aic(kk,2)) '.000.log']
else
    fnm000=[ARGO_SYS_PARAM.root_dir 'iridium_data/iridium_processed/000files/' num2str(aic(kk,2)) '.000.log']
end


% fnm{k}(end-2:end)='log';
% fnm000=fnm{k};
% fnm000(end-6:end-4)='000';
% fnm000=fnm;
% fclose(fid)
fid2=fopen(fnm000);
if fid2==-1
    'Move file to 000files directory! '
    input([' Look in iridium_processed/ ' num2str(wmo_id) ' Done?'],'s')
    fid2=fopen(fnm000);
end
    
floatTech=[];

% fn= [ARGO_SYS_PARAM.root_dir 'matfiles/float' num2str(wmo_id) 'aux.mat']

l=fgetl(fid2);
while(l~=-1)
    config=strfind(l,'LogConfiguration');
    if ~isempty(config)
        l=strtrim(l(config+20:end));
        par=strfind(l,'(');
        par2=strfind(l,')');
        if ~isempty(par)
            if strfind(l,'TimeOf')
                
                mn=['ms.' l(1:par-1) '= ''' l(par+1:par2-1) ''';'];
                eval(mn);
                
            elseif strfind(l,'Debug')
                
                mn=['ms.' l(1:par-1) '= ''' l(par+1:par2-1) ''';'];
                eval(mn);
                
            elseif strfind(l,'IceMonths')
                
                mn=['ms.' l(1:par-1) '= ''' l(par+1:par2-1) ''';'];
                eval(mn);
                
            elseif isempty(strfind(l,'AtD')) & isempty(strfind(l,'AltD')) & isempty(strfind(l,'FloatId')) & ...
                    isempty(strfind(l,'Verbo')) & isempty(strfind(l,'Full')) & isempty(strfind(l,'PActiv')) & ...
                    isempty(strfind(l,'Max')) & isempty(strfind(l,'Mission')) & isempty(strfind(l,'OkV')) & ...
                    isempty(strfind(l,'User')) & isempty(strfind(l,'Pwd')) & ...
                    isempty(strfind(l,'Flbb')) & isempty(strfind(l,'Compens'))
                
                mn=['ms.' l(1:par-1) '=' l(par+1:par2-1) ';'];
                eval(mn);
                
            end
        end
    end
    
    l=fgetl(fid2);
    
end

fclose(fid2);

% This is by definition mission 1 

ms.mission_number = 1;
ms.new_mission = 1;

if ~isempty(ms)
    floatTech.Mission(1)=ms;
end

save (fn,'floatTech','-v6');


