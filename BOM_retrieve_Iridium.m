% function BOM_retrieve_Iridium
% INPUT 
%   - requires ARGO_SYS_PARAM.processor, ARGO_SYS_PARAM.ftp.ftp
%   ARGO_SYS_PARAM.ftp.name,ARGO_SYS_PARAM.ftp.pswd be set in 
%   SET_ARGO_SYS_PARAMS.m
%   - Does nothing if the ARGO_SYS_PARAM.processor field does not exist or
%   is not set to 'CSIRO' or 'BOM'
%
% OUTPUTS
%   - Copies iridium msg, log, isus files from local directory to remote
%   FTP (from CSIRO)
%   - Copies files from FTP to local directory (from BOM)
% 
%
% Author: Rebecca Cowley, CSIRO, October, 2016
%
% CALLS: ftp (matlab built-in) 
%
%
% USAGE: BOM_retrieve_Iridium

function BOM_retrieve_Iridium

% MODS:  many not recorded
%  6/5/2014 JRD Extract extra data for traj V3 files


global ARGO_SYS_PARAM

if isfield(ARGO_SYS_PARAM,'processor')
    
    eval(['cd ' ARGO_SYS_PARAM.iridium_path]);
    % Check for the data processor information - set in set_argo_sys_params.m
    if ~isempty(strfind(ARGO_SYS_PARAM.processor,'CSIRO'))
        % CSIRO copies the data to the FTP
        ftp_conn = ftp(ARGO_SYS_PARAM.ftp.ftp,ARGO_SYS_PARAM.ftp.name,ARGO_SYS_PARAM.ftp.pswd);
        cd(ftp_conn,'iridium_data');
        mput(ftp_conn,'*.000.*');
        mput(ftp_conn,'*.log');
        mput(ftp_conn,'*.msg');
        mput(ftp_conn,'*.isus');
        mput(ftp_conn,'*.system_log.txt');
        mput(ftp_conn,'*.vitals_log.bin');
        mput(ftp_conn,'*.vitals_log.csv');
        mput(ftp_conn,'*.science_log.bin');
        mput(ftp_conn,'*.science_log.csv');
        mput(ftp_conn,'*.rbr_evt_log.bin');
        mput(ftp_conn,'*.rbr_evt_log.csv');
        close(ftp_conn);
    elseif ~isempty(strfind(ARGO_SYS_PARAM.processor,'BOM'))        
        %BOM are retrieving the data from the FTP
        ftp_conn = ftp(ARGO_SYS_PARAM.ftp.ftp,ARGO_SYS_PARAM.ftp.name,ARGO_SYS_PARAM.ftp.pswd);
        
        %now go get the other iridiums
        eval(['cd ' ARGO_SYS_PARAM.iridium_path]);
        cd(ftp_conn,'iridium_data');
        mget(ftp_conn,'*');
        cd(ftp_conn,'../');
        
        %now that they have all the data downloaded, move the files to the
        %hold_iridium_data folder.
        %have to move one at a time, ftp functionality not there for multiple
        %moves with wildcards
        fils = dir(ftp_conn,'/iridium_data/*');
        for aa = 1:length(fils)
            rename(ftp_conn,['./iridium_data/' fils(aa).name],['/hold_iridium_data_sent/' fils(aa).name]);
        end
        close(ftp_conn);
    end
end
% do nothing if you are not BOM or CSIRO.

end