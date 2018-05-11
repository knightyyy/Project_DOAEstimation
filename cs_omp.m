function[hat_x]=cs_omp(m,M,N,Ri,Phi)
% K=2;      
T=Phi;
s=Ri.';
%m=M;
hat_y=zeros(1,N);%  
Aug_t=[];                                         
r_n=s;                                            
for times=1:m                                    
    for col=1:N                                  
        product(col)=abs(T(:,col)'*r_n);          
    end
    [val,pos]=max(product);                       
    Aug_t=[Aug_t,T(:,pos)];                       
    T(:,pos)=zeros(M,1);                          
    aug_y=(Aug_t'*Aug_t)^(-1)*Aug_t'*s;          
    r_n=s-Aug_t*aug_y;                            
    pos_array(times)=pos;                         
end
hat_y(pos_array)=aug_y;                           
hat_x=(hat_y.');                         
end
