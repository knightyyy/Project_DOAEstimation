%% Reconfiguration results of OMP algorithm
function [S_OMP,OMP_est]=OMP_restructure(S_comp,Ptar_num)
load('inital_parameters.mat')
%% Processing in the way of OMP
A=[];
for index_rx=1:RX_num
    A_rx=[];
    kx_1=kx_adjust(index_rx);
%     kz_1=kz_adjust(index_rx);
    for index_x=1:ObjectX_num
        x=ObjectX_pos(index_x);
        A_rx(index_x)=exp(-1j*kx_1*x);
    end
    A=[A;A_rx];
end

S_OMP=cs_omp(Ptar_num,1*RX_num,ObjectX_num,S_comp.',A);
S_OMP=S_OMP./max(S_OMP);
%% Finding the extreme point of the target
S_sort=sort(S_OMP);
for i=1:Ptar_num
    S_sort_size=length(S_sort);
    [rows]=find(S_OMP==S_sort(S_sort_size-i+1));
    OMP_est(i)=(sort(ObjectX_pos(rows)));
end
end
