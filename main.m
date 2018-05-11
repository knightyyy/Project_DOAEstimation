%% Main function
%% The main comparison of the effect of SNR on imaging results
clc;
clear;
close all;
load('inital_parameters.mat')
Ptar=[
    100
%     -100
  110]*diag([rho_x]);
SNR=-25:1:10;
SNR_num=length(SNR);
store_Matrix=zeros(4,SNR_num);

h = waitbar(0,'Please wait...');
for index_SNR=1:SNR_num

[S_comp,Ptar_num]=echo_construction(Ptar,SNR(index_SNR));

%% The FT transform is used to reconstruct the reconfiguration and calculate the error
[S_FT,FT_est]=FT_restructure(S_comp,Ptar_num);
[err_FT]=error_calculation(Ptar,FT_est);
store_Matrix(1,index_SNR)=err_FT;
%% Reconfiguration processing using ESPRIT algorithm
[ESPRIT_est]=ESPRIT_restructure(S_comp,Ptar_num);
[err_ESPRIT]=error_calculation(Ptar,ESPRIT_est);
store_Matrix(2,index_SNR)=err_ESPRIT;
%% Reconfiguration processing using OMP algorithm
[S_OMP,OMP_est]=OMP_restructure(S_comp,Ptar_num);
[err_OMP]=error_calculation(Ptar,OMP_est);
store_Matrix(3,index_SNR)=err_OMP;
% %% Reconfiguration processing using L1SVD algorithm
% [S_L1SVD,L1SVD_est]=L1SVD_restructure(S_comp,Ptar_num);
% [err_L1SVD]=error_calculation(Ptar,L1SVD_est);
% store_Matrix(4,index_SNR)=err_L1SVD;
%% Reconfiguration processing using TSBL algorithm
% [S_TSBL,TSBL_est]=TSBL_restructure(S_comp,Ptar_num);
% [err_TSBL]=error_calculation(Ptar,TSBL_est);
% store_Matrix(4,index_SNR)=err_TSBL;
waitbar(index_SNR/SNR_num,h)
end
figure
plot(SNR,smooth(store_Matrix(1,:),5),'r');
hold on
plot(SNR,smooth(store_Matrix(2,:),5),'g');
hold on
plot(SNR,smooth(store_Matrix(3,:),5),'y');
hold on
plot(SNR,smooth(store_Matrix(4,:),5),'b');
% hold on
% plot(store_Matrix(5,:),'k');
legend('FT algorithm','ESPRIT algorithm','OMP algorithm','TSBL algorithm')
% %% Drawing 1: draw the image result diagram
% figure
% plot(Ptar*100,ones(1,Ptar_num),'ko','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',6);
% hold on
% plot(ObjectX_pos*100,abs(S_FT),'r--','LineWidth',1.5,'MarkerSize',6);
% hold on
% plot(ones(1,50).*ESPRIT_est(1)*100,linspace(0,1.05,50),'b.-','LineWidth',1.5,'MarkerSize',2);
% hold on
% plot(ones(1,50).*ESPRIT_est(2)*100,linspace(0,1.05,50),'b.-','LineWidth',1.5,'MarkerSize',2);
% hold on
% plot(ones(1,50).*ESPRIT_est(3)*100,linspace(0,1.05,50),'b.-','LineWidth',1.5,'MarkerSize',2);
% hold on
% h1=legend('Real target','FT','ESPRIT');
% set(h1,'Fontname','Times New Roman','FontSize',12);
% xlabel('Azimuth(cm)','Fontname','Times New Roman','FontSize',14);
% ylabel('Normalized amplitude','Fontname','Times New Roman','FontSize',14);
% grid on
% axis([-20 20 0 1.05]);
