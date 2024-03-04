clear
close all
clc
set(groot,'defaultAxesFontSize',12)

n = 10;

col = cool(n);
M = 2.^(2:n);

figure
colormap cool;

for j = 1:length(M)
    
    m = M(j);
    omegas = 0:0.01:2;
    
    maxlambdas = zeros(length(omegas),1);
    
    for i = 1:length(omegas)
    
        lambdas = computeEigenval(m,omegas(i));
    
        maxlambdas(i) = max(max(abs(lambdas(m/2:m,m/2:m))));
    
    end
    
    plot(omegas,maxlambdas,'-',Color=col(j,:))
    hold on

end

grid on

legend(strcat('m=',string(M)),'Location',"southeast")
xlabel("omega")
ylabel("Largest eigenvalue")

% colorbar('Ticks',M,'TickLabels',string(M))

