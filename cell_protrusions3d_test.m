%% clear
clc; clear all; close all;

%% path
addpath('./lib')
addpath('../blob3d/lib')

%% load image
im = imread3d('./im/cell.tif');

%% normalize
im = double(im); im = (im - min(im(:))) / (max(im(:)) - min(im(:))); 

%% cell body and cell protrusions segmentation
s = 15; ds = 2;
[imc,imp] = cell_protrusions3d(im,s,ds);

%% plot
z = 50;
figure; imagesc(im(:,:,z)); colormap gray;
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;

figure; imagesc(double(imc(:,:,z)) + double(imp(:,:,z))); colormap gray;
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;