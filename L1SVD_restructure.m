%% Reconfiguration results of L1SVD algorithm
function [S_L1SVD,L1SVD_est]=L1SVD_restructure(S_comp,Ptar_num)
load('inital_parameters.mat')
%% Processing in the way of L1SVD
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

cvx_begin
    variable x(3788);
    minimize(square_pos(norm(S_comp-A*x,2))+2*norm(x,1));
cvx_end
S_L1SVD=x;
%% Finding the extreme point of the target
S_sort=sort(S_L1SVD);
for i=1:Ptar_num
    S_sort_size=length(S_sort);
    [rows]=find(S_L1SVD==S_sort(S_sort_size-i+1));
    L1SVD_est(i)=(sort(ObjectX_pos(rows)));
end
end
