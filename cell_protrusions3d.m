function [imc,imp] = cell_protrusions3d(im,s,ds)
%%  vector_field_var2d - 2d vector field variance
%   
%   REFERENCE:
%       T.M.E. Scales, B. Obara, M.R. Holt, N.A. Hotchin, F. Berditchevski, 
%       M. Parsons, alpha3beta1 integrins regulate CD151 complex assembly 
%       and membrane dynamics of carcinoma cells within 3D environments, 
%       Oncogene, 32, 34, 3965-3979,2013
%
%   INPUT:
%       im      - cell image
%       s       - se size
%       ds      - distance size
%       r       - radius
%
%   OUTPUT:
%       imc     - segmented cell body image
%       imp     - segmented cell protrusions image
%
%   AUTHOR:
%       Boguslaw Obara

%% cell segmentation
t = graythresh(im);
imc = im>t;

%% filter holes
imc = imfill(imc,'holes');

%% largest object
imlabel = bwlabeln(imc);
stats = regionprops3(imlabel,'Volume');
[~,idx] = max([stats.Volume]);
imc = ismember(imlabel,idx);

%% cell protrusions
se = strel('disk',s); 
% se = strel('sphere',s);
imp = imc;
imp = imopen(imp,se);
imp = imclose(imp,se);

imd = bwdist(imp);
imd(~imc) = 0;
imp = imd>ds;

end