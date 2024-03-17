function U = multigrid(U,F,l,omega,nsmooth,epsilon,maxiter)
    
    m=2^l-1;
    
    R = F + Amult(U,m);

    for i=1:maxiter 
        
        if(norm(R, 2)/norm(F, 2) < epsilon)
            break;
        end

        U = VCycle(U, F, l, omega, nsmooth);

        R = F + Amult(U,m);
    end
end