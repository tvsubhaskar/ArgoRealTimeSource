%recreate netcdf files for selected floats
%adapt to suit the need!

global THE_ARGO_FLOAT_DB
global ARGO_SYS_PARAM
global THE_ARGO_BIO_CAL_DB  ARGO_BIO_CAL_WMO
getBiocaldbase
if isempty(ARGO_SYS_PARAM)
    set_argo_sys_params;
end
global ARGO_ID_CROSSREF PREC_FNM
getdbase(-1)
PREC_FNM = [ARGO_SYS_PARAM.root_dir 'Argo_proc_records'];

kk = [5904923];
ipath = ARGO_SYS_PARAM.iridium_path;
for ii = 1:length(kk)
    disp(ii)
    [fpp,dbdat]=getargo(kk(ii));

% if any([dbdat.flbb,dbdat.flbb2,dbdat.irr, dbdat.irr2, ...
%             dbdat.pH])
        %change the path temporarily:
        ARGO_SYS_PARAM.iridium_path = [ipath 'iridium_processed/' ...
            num2str(dbdat.wmo_id) '/'];
%     if dbdat.oxy
        for j=1:length(fpp)
            [ii j]
            if ~isempty(fpp(j).lat)
                try
                    pmeta.wmo_id = dbdat.wmo_id;
                    pmeta.ftptime = fpp(j).ftp_download_jday(1);
                    pn = '000';
                    pns = num2str(j);
                    pn(end-length(pns)+1:end) = pns;
                    pmeta.ftp_fname = [dbdat.argos_hex_id '.' pn '.msg'];
                    opts.rtmode = 0;
                    process_iridium(pmeta,dbdat,opts) %need to recalculate bbp
%                     argoprofile_Bfile_nc(dbdat,fpp(j))
                    % or could run argoprofile_nc here too
                catch
                    bad = [bad;ii,j];
                end
            end
        end
%     end
end