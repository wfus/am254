colors ={’k’,’r’,’b’,’g’};
line_type ={’-’,’:’,’-.’,’--’};
figure
h=zeros(1,length(N));
str_N=cell(1,length(N));
for k=1: length(N)
cl=colors{k};
lt=line_type{k};
str_N{k}=[’N=’ num2str(N(k))];
alpha=alphas{k};
succ=succ_all{k};
h(k)=plot(alpha , succ (1: length(alpha )),[cl   lt] );
hold on
end
legend(h,str_N);
xlabel(’\alpha’);
ylabel(’P’);
axis ([0 1 0 1])
legend(’Location ’,’northwest ’)
hold  of