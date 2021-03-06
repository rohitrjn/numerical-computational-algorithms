str=input('Enter the input filename including extension :','s');
fid = fopen(str,'r');
n=fscanf(fid,'%f',[1 1]);
A=fscanf(fid,'%f',[n+1 n]);
A=A';
fclose(fid);

%%
B=A(1:n,1:n);

% pivoting
for i = 1:n-1
    [maxc , m]= max(A(i:n,i));
    m=m+i-1;
    A([i m],:)=A([m i],:);  
end

PiA=A(1:n,1:n);   % Pivoted Matrix of coefficients only

% forward substitution
for i = 1:n-1
   for j = i+1:n
       l(j,i) = A(j,i)/A(i,i);
       for k = i:n+1
           A(j,k) = A(j,k)-l(j,i)*A(i,k);
       end
   end
end

% backward elimination
x(n)=A(n,n+1)/A(n,n);

for i=1:n-1
    sum=0;
    for j=1:i
        sum=sum+A(n-i,n+1-j)*x(n+1-j);
    end
    x(n-i)=(A(n-i,n+1)-sum)/A(n-i,n-i);
end

P = PiA*inv(B); % calculating Permutation Matrix

% printing output

f = fopen('output_1.txt','wt');
fprintf(f,'X = \n');

for j = 1:n
        fprintf(f,'%f\n',x(j));
end

fprintf(f,'\nP = \n');

for i = 1:n
    for j = 1:n
        fprintf(f,'%f ',P(i,j));
    end
    fprintf(f,'\n');
end

fprintf(f,'\nU = \n');

for i = 1:n
    for j = 1:n
        fprintf(f,'%f ',A(i,j));
    end
    fprintf(f,'\n');
end
