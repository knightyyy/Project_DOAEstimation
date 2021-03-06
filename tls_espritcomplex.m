function estimate=tls_espritcomplex(dd,cr,Le)
twpi=2*pi;
derad=pi/180;
radeg=180/pi;
% Eigenvalue decomposition is applied to the covariance matrix of received signals.
[K,KK]=size(cr);
[V,D]=eig(cr);
EVA=real(diag(D)');
[EVA,I]=sort(EVA);
EVA=fliplr(EVA);
EV=fliplr(V(:,I));
% Eigenvalue decomposition
Exy=[EV(1:K-1,1:Le) EV(2:K,1:Le)];
E_xys=Exy'*Exy;
%Construction of E_xys
[V,D]=eig(E_xys);
EVA_xys=real(diag(D)');
[EVA_xys,I]=sort(EVA_xys);
EVA_xys=fliplr(EVA_xys);
EV_xys=fliplr(V(:,I));
%Decompose EV_xys
Gx=EV_xys(1:Le,Le+1:Le*2);
Gy=EV_xys(Le+1:Le*2,Le+1:Le*2);
Psi=-Gx/Gy;
[V,D]=eig(Psi);
EGS=diag(D).';
[EGS,I]=sort(EGS);
EGS=fliplr(EGS);
EVS=fliplr(V(:,I));
%Estimate DOA
ephi=atan2(imag(EGS),real(EGS));
ange=-ephi/(dd);
estimate(1,:)=-ange;
% T=inv(EVS);
% powe=T*diag(EVA(1:Le)-EVA(K))*T';
% powe=abs(diag(powe).')/K;
% estimate(2,:)=powe;
