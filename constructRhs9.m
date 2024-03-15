function [X,Y,F] = constructRhs9(m,f,g,flag)
    
    % For testing, it's the exact second order laplacian of f. 
    d2f = @(x,y) 256*pi^2*(4*pi^2*sin(4*pi*(x + y)) + ...
                 (-1/4 + (x^2 + y^2)^2*pi^2)*cos(4*pi*x*y) + ...
                 2*pi*y*sin(4*pi*x*y)*x);

    X = zeros(m^2,1);
    Y = zeros(m^2,1);
    
    F = zeros(m^2,1);

    h = 1/(m+1);

    k = 0;

    for i = 1:m
        for j = 1:m

            k = k + 1;

            x = i*h;
            y = j*h;

            X(k) = x;
            Y(k) = y;

            if i == 1 && j == 1 % Bottom left
                
                % Upleft
                x1 = (i-1)*h;
                y1 = (j+1)*h;

                % Left
                x2 = (i-1)*h;
                y2 = j*h;

                % Downleft
                x3 = (i-1)*h;
                y3 = (j-1)*h;

                % Down
                x4 = i*h;
                y4 = (j-1)*h;

                % Downright
                x5 = (i+1)*h;
                y5 = (j-1)*h;
                
                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3) + ...
                       4*g(x4,y4) + g(x5,y5))/(6*h^2);

            elseif i == m && j == m % Top right
                
                % Downright
                x1 = (i+1)*h;
                y1 = (j-1)*h;

                % Right
                x2 = (i+1)*h;
                y2 = j*h;

                % Upright
                x3 = (i+1)*h;
                y3 = (j+1)*h;

                % Up
                x4 = i*h;
                y4 = (j+1)*h;

                % Upleft
                x5 = (i-1)*h;
                y5 = (j+1)*h;
                
                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3) + ...
                       4*g(x4,y4) + g(x5,y5))/(6*h^2);

            elseif i == 1 && j == m % Top left
                
                % Upleft
                x1 = (i-1)*h;
                y1 = (j+1)*h;

                % Left
                x2 = (i-1)*h;
                y2 = j*h;

                % Downleft
                x3 = (i-1)*h;
                y3 = (j-1)*h;

                % Up
                x4 = i*h;
                y4 = (j+1)*h;

                % Upright
                x5 = (i+1)*h;
                y5 = (j+1)*h;
                
                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3) + ...
                       4*g(x4,y4) + g(x5,y5))/(6*h^2);
            
            elseif i == m && j == 1 % Bottom right
                
                % Upright
                x1 = (i+1)*h;
                y1 = (j+1)*h;

                % Right
                x2 = (i+1)*h;
                y2 = j*h;

                % Downleft
                x3 = (i-1)*h;
                y3 = (j-1)*h;

                % Down
                x4 = i*h;
                y4 = (j-1)*h;

                % Downright
                x5 = (i+1)*h;
                y5 = (j-1)*h;
                
                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3) + ...
                       4*g(x4,y4) + g(x5,y5))/(6*h^2);

            elseif i == 1 % Left
                
                % Upleft
                x1 = (i-1)*h;
                y1 = (j+1)*h;

                % Left
                x2 = (i-1)*h;
                y2 = j*h;

                % Downleft
                x3 = (i-1)*h;
                y3 = (j-1)*h;

                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3))/(6*h^2);

            elseif i == m % Right
                
                % Downright
                x1 = (i+1)*h;
                y1 = (j-1)*h;

                % Right
                x2 = (i+1)*h;
                y2 = j*h;

                % Upright
                x3 = (i+1)*h;
                y3 = (j+1)*h;

                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3))/(6*h^2);

            elseif j == 1 % Bottom
                
                % Downright
                x1 = (i+1)*h;
                y1 = (j-1)*h;

                % Down
                x2 = i*h;
                y2 = (j-1)*h;

                % Downleft
                x3 = (i-1)*h;
                y3 = (j-1)*h;

                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3))/(6*h^2);
                
            elseif j == m % Top
                
                % Upright
                x1 = (i+1)*h;
                y1 = (j+1)*h;

                % Up
                x2 = i*h;
                y2 = (j+1)*h;

                % Upleft
                x3 = (i-1)*h;
                y3 = (j+1)*h;

                F(k) = f(x,y) - (g(x1,y1) + 4*g(x2,y2) + g(x3,y3))/(6*h^2);

            else
                
                F(k) = f(x,y);

            end
        end
    end

    k = 0;

    Xfull = zeros((m+2)^2,1);
    Yfull = zeros((m+2)^2,1);

    for i = 1:(m+2)
        for j = 1:(m+2)

            k = k + 1;

            x = (i-1)*h;
            y = (j-1)*h;

            Xfull(k) = x;
            Yfull(k) = y;

        end
    end

    if flag % flag = true -> use correction

        % % f evaluated at all nodes
        Ftemp = arrayfun(f,Xfull,Yfull);
    
        % Constructing poisson5 manually kindof
        e = ones(m+2,1);
        S = spdiags([e -2*e e], [-1 0 1], m+2, m+2);
        I = speye(m+2);
        A = kron(I,S)+kron(S,I);
        A = (1/h^2)*A;

        % Computing correction term
        correctionTerm = reshape((h^2/12)*A*Ftemp,m+2,m+2);
    
        correctionTerm(:,1) = []; % First column
        correctionTerm(:,end) = []; % Last column
        correctionTerm(1,:) = []; % First row
        correctionTerm(end,:) = []; % Last row
    
        F = F + correctionTerm(:);
    
    end

    % d2F = arrayfun(d2f,X,Y);
    % 
    % correctionTerm = (h^2/12)*d2F;
    % 
    % F = F + correctionTerm;

end