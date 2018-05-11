%% This program is aimed at setting inital parameters
clc;
clear ;
close all;
c=3e8;
fc=183e9;%center frequency
lambda=c/fc;
Rz=-0.4;%The distance between the center of the target and the plane of the observation
k=2*pi*fc/c;%Wavenumber domain frequency
thetaX_annt=15*pi/180;%The direction angle of the antenna is 15 degrees
%% Synthetic aperture is the observation plane setting
D=0.3;%Synthetic aperture size
RX_num=360;%Number of sampling positions of synthetic aperture
deltaX=D/RX_num;%Interval between sampling positions
deltaX_standard=lambda/2;%The standard sampling interval is at least half a wavelength
RX_pos=linspace(-D/2,D/2,RX_num);%Setting the sampling location
Lx=D/2;%Set an intermediate variable
thetaX_span=2*asin(Lx/sqrt(Rz^2+Lx^2));
thetaX=min(thetaX_span,thetaX_annt);%Determining the angle of wave number domain
TX=-0.2;
TZ=0;%Represent the fixed position of the transmitter
%% Observation plane setting
rho_x=lambda/2*sin(thetaX/2);%Azimuth dimension resolution
ObjectX_max=(D+2*abs(Rz)*tan(thetaX/2));%Maximum measurable range of target plane
% ObjectX_num=floor(ObjectX_max/rho_x);%Target plane grid number
ObjectX_num=360;
ObjectX_pos=linspace(-ObjectX_max/2,ObjectX_max/2,ObjectX_num);
%% Frequency construction in wavenumber domain
kx_range=k*Lx/sqrt(Lx^2+Rz^2);
kx=linspace(-kx_range,kx_range,RX_num);
kx_adjust=kx+k.*TX/sqrt(TX^2+TZ^2);
kz=sqrt(k.^2-kx.^2);
kz_adjust=kz*abs(Rz)+k*sqrt(TX^2+TZ^2);
%% Data export
save inital_parameters.mat
