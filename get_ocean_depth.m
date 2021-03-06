% GET_OCEAN_DEPTH  Find deepest and shallowest point within +/- .25 deg of each position
%
%   ** WARNING:  Hardcoded bathymetry file name!
%
% INPUT:  lat,lon - lat and lon for npos positions
%
% OUTPUT: dep - deepest point in bathymetry set within +/- .25 degrees
%
% Jeff Dunn  CSIRO/BoM  Aug 2006
%
% CALLED BY:  process_profile
%
% USAGE: [dep] = get_ocean_depth(lat,lon);
% 

function [dep] = get_ocean_depth(lat,lon, dist)

global ARGO_SYS_PARAM

persistent XB YB

fname = ARGO_SYS_PARAM.ocean_depth;

if isempty(XB)
   % First call, so load bathymetry grid coords
   XB = getnc(fname,'lon');
   YB = getnc(fname,'lat');
end

% If for any reason we can't get depths, then 5000 is a benign fillin.
dep = repmat(5000,size(lat));
if nargin<3;dist=0.25;end

% Want longitude in range 0-360
if any(lon<0)
   ii = find(lon<0);
   lon(ii) = lon(ii) + 360;
end
% If we are wrapping around 0E, this test is not worth the complication it
% entails, so just go back.
if any(lon<.3 | lon>359.7)
   return
end

% Use lx,ly to find out if the subsampled locations in the bathy dataset
% change from one position to the next. If not, we save time by not reloading
% the bathymetry.

lx = 9999999999999; ly = [];


for ii = 1:size(lat)
   ix = find(XB >= lon(ii)-dist & XB <= lon(ii)+dist);
   iy = find(YB >= lat(ii)-dist & YB <= lat(ii)+dist);

   if length(union(ix,lx))~=length(ix) | length(union(iy,ly))~=length(iy) 
      hb = -1*getnc(fname,'height',[min(iy) min(ix)],[max(iy) max(ix)]);
      lx = ix;
      ly = iy;
   end
   dep(ii) = max(hb(:));
%    mindep(ii) = min(hb(:));
end

return
%-------------------------------------------------------------------------
