function [] = convergencePlot(uexact,solver,resolution,convrate,varargin)
        
    n = length(resolution);

    err = zeros(n,1);

    for i = 1:n

        [X,Y,U] = solver(resolution(i),varargin{:});
        
        udiscrete = arrayfun(uexact,X,Y);
    
        err(i) = max(abs(udiscrete-U));
    
    end
    
    % Reference convergence line
    refcon = (1./resolution).^convrate;

    lnw = 1.5;
    
    loglog((1./resolution),err,'-','LineWidth',lnw)
    hold on
    loglog((1./resolution),refcon,'--','LineWidth',lnw)
    grid on
    legend("Error","Reference convergence (h^p)")
    xlabel('h')
    ylabel('||e||')

end