function [S_comp,Ptar_num]=echo_construction(Ptar,SNR)
%This program is the construction of echo signal
%Ptar is represent the target point
load('inital_parameters.mat')
Ptar_num=length(Ptar);
% Ptar_amp=randn(Ptar_num,1);
%% echo construction
S=zeros(RX_num,1);
for index_x=1:RX_num
    s=0;
    for index_tar=1:Ptar_num
        xn=Ptar(index_tar);
        sigma=1;
        R_TX=sqrt((xn-TX)^2+TZ.^2);
        R_RX=sqrt((xn-RX_pos(index_x))^2+Rz^2);
        s=s+sigma*exp(1j*k*(R_TX+R_RX));
    end
    S(index_x,:)=s;
end
S=awgn(S,SNR);
%% Wave number domain frequency calculation
kx_range=k*Lx/sqrt(Lx^2+Rz^2);
kx=linspace(-kx_range,kx_range,RX_num);

%% Fourier transform processing of echo signal
S_ftx=exp(-1j*kx.'*RX_pos)*S;
%% Phase compensation processing for wavenumber domain signals
S_comp=S_ftx.*exp(-1j*kz_adjust.');
