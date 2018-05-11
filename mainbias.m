%% Main function
%% The effect of the interval between two targets on imaging results is mainly compared.
clc;
clear;
close all;
load('inital_parameters.mat')
Ptar_bias=1:1:40;
SNR=0;
bias_num=length(Ptar_bias);

h = waitbar(0,'Please wait...');
store_Matrix=zeros(3,bias_num);
for index_bias=1:bias_num

 Ptar=[
    0
  0+Ptar_bias(index_bias)]*diag([rho_x]);
[S_comp,Ptar_num]=echo_construction(Ptar,SNR);
for index_re=1:20
%% The FT transform is used to reconstruct the reconfiguration and calculate the error
[S_FT,FT_est]=FT_restructure(S_comp,Ptar_num);
[err_FT]=error_calculation(Ptar,FT_est);
store_Matrix(1,index_bias)=store_Matrix(1,index_bias)+err_FT;
%% Reconfiguration processing using ESPRIT algorithm
[ESPRIT_est]=ESPRIT_restructure(S_comp,Ptar_num);
[err_ESPRIT]=error_calculation(Ptar,ESPRIT_est);
store_Matrix(2,index_bias)=store_Matrix(2,index_bias)+err_ESPRIT;
%% Reconfiguration processing using OMP algorithm
[S_OMP,OMP_est]=OMP_restructure(S_comp,Ptar_num);
[err_OMP]=error_calculation(Ptar,OMP_est);
store_Matrix(3,index_bias)=store_Matrix(3,index_bias)+err_OMP;
% %% Reconfiguration processing using L1SVD algorithm
% [S_L1SVD,L1SVD_est]=L1SVD_restructure(S_comp,Ptar_num);
% [err_L1SVD]=error_calculation(Ptar,L1SVD_est);
% store_Matrix(4,index_SNR)=err_L1SVD;
% %% Reconfiguration processing using TSBL algorithm
% [S_TSBL,TSBL_est]=TSBL_restructure(S_comp,Ptar_num);
% [err_TSBL]=error_calculation(Ptar,TSBL_est);
% store_Matrix(4,index_bias)=err_TSBL;
waitbar(index_bias/bias_num,h)
end
end
figure
plot(Ptar_bias,smooth(((store_Matrix(1,:)./20))),'r-');
hold on
plot(Ptar_bias,smooth((store_Matrix(2,:)./20)),'g');
hold on
plot(Ptar_bias,smooth((store_Matrix(3,:)./20)),'b');
% hold on
% plot(Ptar_bias,smooth(store_Matrix(4,:),5),'b');
% hold on
% plot(store_Matrix(5,:),'k');
legend('FT algorithm','ESPRIT algorithm','OMP algorithm','TSBL algorithm')
% %% Drawing 1: draw the image result diagram
figure
plot(Ptar*100,ones(1,Ptar_num),'ko','MarkerFaceColor','k','LineWidth',1.5,'MarkerSize',6);
hold on
plot(ObjectX_pos*100,abs(S_FT),'r--','LineWidth',1.5,'MarkerSize',6);
hold on
plot(ones(1,50).*ESPRIT_est(1)*100,linspace(0,1.05,50),'b.-','LineWidth',1.5,'MarkerSize',2);
hold on
plot(ones(1,50).*ESPRIT_est(2)*100,linspace(0,1.05,50),'b.-','LineWidth',1.5,'MarkerSize',2);
hold on
% plot(ones(1,50).*ESPRIT_est(3)*100,linspace(0,1.05,50),'b.-','LineWidth',1.5,'MarkerSize',2);
% hold on
% h1=legend('Real target','FT','ESPRIT');
% set(h1,'Fontname','Times New Roman','FontSize',12);
% xlabel('Azimuth(cm)','Fontname','Times New Roman','FontSize',14);
% ylabel('Normalized amplitude','Fontname','Times New Roman','FontSize',14);
% grid on
% axis([-20 20 0 1.05]);
