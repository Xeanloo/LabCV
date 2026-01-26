function p = TDLS(M, xStart, yStart, w)
    % Block Matching (Two Dimensional Logarithmic Search)
    % M: (m x n x c x t) array
    
    [m, n, ~, t] = size(M);
    p = zeros(2, t);
    p(:, 1) = [xStart; yStart];

    for i = 2:t
        % 1. Setup frames and the FIXED reference block from the previous frame
        I_old = M(:, :, :, i - 1);
        I_new = M(:, :, :, i);
        
        prev_x = p(1, i-1);
        prev_y = p(2, i-1);
        
        % Extract the reference block (handle boundaries if necessary)
        % Using max/min to prevent indexing errors if the object is near the edge
        y_range = max(1, prev_y-w):min(m, prev_y+w);
        x_range = max(1, prev_x-w):min(n, prev_x+w);
        blockRef = double(I_old(y_range, x_range, :));

        curr_x = prev_x;
        curr_y = prev_y;
        s = 8;

        while s > 1
            directions = [0, s, -s, 0, 0; 
                          0, 0, 0, s, -s];
            
            best_dx = 0;
            best_dy = 0;
            minSAD = inf;

            for k = 1:5
                cand_x = curr_x + directions(1, k);
                cand_y = curr_y + directions(2, k);

                if cand_x-w < 1 || cand_x+w > n || cand_y-w < 1 || cand_y+w > m
                    continue;
                end

                blockCand = double(I_new(cand_y-w:cand_y+w, cand_x-w:cand_x+w, :));
                
                SAD = sum(abs(blockRef(:) - blockCand(:)));

                if SAD < minSAD
                    minSAD = SAD;
                    best_dx = directions(1, k);
                    best_dy = directions(2, k);
                end
            end

            curr_x = curr_x + best_dx;
            curr_y = curr_y + best_dy;

            % Only halve step size if the center was the best
            if best_dx == 0 && best_dy == 0
                s = s / 2;
            end
        end

        %  3x3 grid around final point
        minSAD = inf;
        final_x = curr_x;
        final_y = curr_y;

        for dx = -1:1
            for dy = -1:1
                cand_x = curr_x + dx;
                cand_y = curr_y + dy;

                if cand_x-w < 1 || cand_x+w > n || cand_y-w < 1 || cand_y+w > m
                    continue;
                end

                blockCand = double(I_new(cand_y-w:cand_y+w, cand_x-w:cand_x+w, :));
                SAD = sum(abs(blockRef(:) - blockCand(:)));

                if SAD < minSAD
                    minSAD = SAD;
                    final_x = cand_x;
                    final_y = cand_y;
                end
            end
        end

        p(:, i) = [final_x; final_y];
    end
end