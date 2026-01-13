function X = myTriangulation(x1, x2, P1, P2)
    
    % TODO
    % rebuild the 3d points from two image points and two projection matrices
    n = size(x1, 1);
    X = zeros(n, 3);
    for i = 1:n
        A = [x1(i,1)*P1(3,:) - P1(1,:);
            x1(i,2)*P1(3,:) - P1(2,:);
            x1(i,1)*P1(2,:) - x1(i,2)*P1(1,:);
            x2(i,1)*P2(3,:) - P2(1,:);
            x2(i,2)*P2(3,:) - P2(2,:);
            x2(i,1)*P2(2,:) - x2(i,2)*P2(1,:)];         
        [~, ~, V] = svd(A);
        X_hom = V(:, end);
        X(i, :) = (X_hom(1:3) / X_hom(4))';
    end

end
