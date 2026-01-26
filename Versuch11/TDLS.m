function p = TDLS(M, xStart, yStart, w)
% Block Matching (Two Dimensional Logarithmic Search)
%
% Eingabe: M - Video, (m x n x 3 x t)-Array
%          xStart, yStart - Startpunkt
%          w - Fenstergröße
%
% Ausgabe: p - (2 x t)-Array, verfolgter Pfad.

    [m, n, ~, t] = size(M);
    p = zeros(2, t);
    p(:, 1) = [xStart; yStart];

    
    for f_idx = 2:t
        old_frame = M(:, :, :, f_idx - 1);
        new_frame = M(:, :, :, f_idx);
        curr_x = p(1, f_idx - 1);
        curr_y = p(2, f_idx - 1);
        stepSize = 8;
        while stepSize >= 1
            best_x = curr_x;
            best_y = curr_y;
            minSAD = inf;
            for dx = -stepSize:stepSize:stepSize
                for dy = -stepSize:stepSize:stepSize
                    cand_x = curr_x + dx;
                    cand_y = curr_y + dy;
                    if cand_x - w < 1 || cand_x + w > n || ...
                       cand_y - w < 1 || cand_y + w > m
                        continue;
                    end
                    blockPrev = old_frame(curr_y-w:curr_y+w, curr_x-w:curr_x+w, :);
                    blockCurr = new_frame(cand_y-w:cand_y+w, cand_x-w:cand_x+w, :);
                    SAD = sum(abs(double(blockPrev(:)) - double(blockCurr(:))));
                    if SAD < minSAD
                        minSAD = SAD;
                        best_x = cand_x;
                        best_y = cand_y;
                    end
                end
            end
            curr_x = best_x;
            curr_y = best_y;
            stepSize = stepSize / 2;
        end
        prev_x = p(1, f_idx - 1);
        prev_y = p(2, f_idx - 1);
        for dx = -1:1
            for dy = -1:1
                cand_x = curr_x + dx;
                cand_y = curr_y + dy;
                if cand_x - w < 1 || cand_x + w > n || ...
                   cand_y - w < 1 || cand_y + w > m
                    continue;
                end
                blockPrev = old_frame(prev_y-w:prev_y+w, prev_x-w:prev_x+w, :);
                blockCurr = new_frame(cand_y-w:cand_y+w, cand_x-w:cand_x+w, :);
                SAD = sum(abs(double(blockPrev(:)) - double(blockCurr(:))));
                if SAD < minSAD
                    minSAD = SAD;
                    best_x = cand_x;
                    best_y = cand_y;
                end
            end
        end
        p(:, f_idx) = [best_x; best_y]; 
    end


end