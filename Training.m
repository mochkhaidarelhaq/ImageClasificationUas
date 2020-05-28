clc;
clear all;
close all;
%% Mengambil Gambar
[fname, path]=uigetfile({'*.png;*.jpg'},'buka sebuah gambar sebagai input untuk training');
fname=strcat(path, fname);
im=imread(fname);
im=im2bw(im);
imshow(im);
title('Input Image');
c=input('Enter the Class(Number from 1-12)');
%% Ekstrasi Fitur
F=FeatureStatistical(im);
try 
    load ds;
    F=[F c];
    ds=[ds; F];
    save ds.mat ds 
catch 
    ds=[F c]; % 10 12 1
    save ds.mat ds 
end
    



