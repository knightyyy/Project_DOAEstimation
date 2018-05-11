function [err]=error_calculation(Ptar,est)
% this program is the calculation of error
Ptar_num=length(Ptar);
est_sort=sort(est);
Ptar_sort=sort(Ptar);
err=(sqrt(sum(abs(Ptar_sort(:)-est_sort(:)).^2)))/Ptar_num;
% err=abs(abs(Ptar_sort(1)-Ptar_sort(2))-abs(est(1)-est(2)))/abs(Ptar_sort(1)-Ptar_sort(2));
end
