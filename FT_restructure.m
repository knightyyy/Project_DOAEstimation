function [S_FT,FT_est]=FT_restructure(S_comp,Ptar_num)
% this program is using FT algorithm to restructure the target points
load('inital_parameters.mat')
S_iftx = exp(1j * ObjectX_pos.' * kx_adjust) * S_comp./RX_num;
S_FT=S_iftx./(max(S_iftx));%normalized
%% Peak search
S_sort=sort(S_iftx);
for i=1:Ptar_num
    S_sort_size=length(S_sort);
    [rows]=find(S_iftx==S_sort(S_sort_size-i+1));
    FT_est(i)=(sort(ObjectX_pos(rows)));
end
end
