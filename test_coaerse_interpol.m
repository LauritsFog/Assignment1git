A = [1,2,3,4,5; 6,7,8,9,0; 9,8,7,6,5; 1,3,5,7,9; 8,6,4,2,0];
disp(A)
for i=1:100
    A=smudge(A);
    disp(A);
end

function mat = smudge(A)
    k=size(A);
    kk=k(1);
    %disp(A)
    B = reshape(interpolate(A,k(1)), kk*2+1, kk*2+1);
    %disp(B)
    C= coarsen2(B, kk*2+1);
    %disp(C)
    mat=C;
end
