function [ESPRIT_est]=ESPRIT_restructure(S_comp,Ptar_num)
load('inital_parameters.mat')
%% The program is using ESPRIT algorithm to DOA estimation
%% and using smoothing procssing for compensation signal
Rxxm=S_comp *S_comp'/1;
issp=2;% the length of subarray
K=RX_num/2;
if issp==1
    Rxx=ssp(Rxxm,K);
elseif issp==2
    Rxx=mssp(Rxxm,K);
else
    Rxx=Rxxm;
    K=RX_num;
end
dd=2*kx_range/RX_num;
estimate=tls_espritcomplex(dd,Rxx,Ptar_num);
ESPRIT_est=-estimate;
end
