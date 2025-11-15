%% Laden der Daten

    % TODO
    genderData = load('genderData.mat');
    height_male = genderData.height_m_in_cm;
    height_female = genderData.height_f_in_cm;
    weight_male = genderData.weight_m_in_kg;
    weight_female = genderData.weight_f_in_kg;
%% Schätzung der Parameter der Verteilungen

    % TODO
    mu_height_male = mean(height_male);
    var_height_male = var(height_male);
    sigma_height_male = std(height_male);
    mu_height_female = mean(height_female);
    var_height_female = var(height_female);
    sigma_height_female = std(height_female);

    mu_weight_male = mean(weight_male);
    var_weight_male = var(weight_male);
    sigma_weight_male = std(weight_male);
    mu_weight_female = mean(weight_female);
    var_weight_female = var(weight_female);
    sigma_weight_female = std(weight_female);
    %% Darstellung der geschätzen Verteilungen

    % TODO
    height_range = linspace([min([height_male; height_female]) - 10], [max([height_male; height_female]) + 15], 1000);
    weight_range = linspace([min([weight_male; weight_female]) - 10], [max([weight_male; weight_female]) + 15], 1000);

    figure;
    subplot(2,1,1);
    hold on
    plot(height_range, normpdf(height_range, mu_height_male, sigma_height_male), 'r', 'DisplayName', 'Male');
    plot(height_range, normpdf(height_range, mu_height_female, sigma_height_female), 'b', 'DisplayName', 'Female');
    title('Height Distribution');
    xlabel('Height (cm)');
    ylabel('Probability Density');
    legend;
    hold off;

    subplot(2,1,2);
    hold on
    plot(weight_range, normpdf(weight_range, mu_weight_male, sigma_weight_male), 'r', 'DisplayName', 'Male');
    plot(weight_range, normpdf(weight_range, mu_weight_female, sigma_weight_female), 'b', 'DisplayName', 'Female');
    title('Weight Distribution');
    xlabel('Weight (kg)');
    ylabel('Probability Density');
    legend;
    hold off;


    cov_male = cov([height_male, weight_male]);
    cov_female = cov([height_female, weight_female]);

    fprintf('Male covariance matrix:\n');
    disp(cov_male);
    fprintf('Expected variances - Height: %.2f, Weight: %.2f\n', var_height_male, var_weight_male);
    
    fprintf('\nFemale covariance matrix:\n');
    disp(cov_female);
    fprintf('Expected variances - Height: %.2f, Weight: %.2f\n', var_height_female, var_weight_female);

    %% Task C)
    mu_male = [mu_height_male, mu_weight_male];
    mu_female = [mu_height_female, mu_weight_female];
    [H, W] = meshgrid(height_range, weight_range);
    X = [H(:), W(:)];
    
    pdf_male = mvnpdf(X, mu_male, cov_male);
    pdf_female = mvnpdf(X, mu_female, cov_female);

    pdf_male = reshape(pdf_male, size(H));
    pdf_female = reshape(pdf_female, size(H));
    
    % 3D surface plot
    figure;
    hold on;
    surf(H, W, pdf_male, 'FaceColor', 'r', 'FaceAlpha', 0.5, 'EdgeColor', 'none');
    surf(H, W, pdf_female, 'FaceColor', 'b', 'FaceAlpha', 0.5, 'EdgeColor', 'none');
    xlabel('Height (cm)');
    ylabel('Weight (kg)');
    zlabel('Probability Density');
    title('2D Multivariate Normal Distributions');
    legend('Male', 'Female');
    view(45, 30);
    hold off;

%% Naiver Bayes Klassifikator
%  Variablen unabhängig, eindimensionale Normalverteilungen

    % TODO
    f1 = [182, 79];
    f2 = [188, 130];
    f3 = [195, 95];
    
    % Prior probabilities
    p_male = 0.5;
    p_female = 0.5;
    
    % Classify using naive Bayes (features are independent)
    persons = {f1, f2, f3};
    
    fprintf('\n=== Naive Bayes Classification ===\n');
    for i = 1:3
        person = persons{i};
        height = person(1);
        weight = person(2);
        
        % Naive Bayes: Product of individual 1D normal distributions
        % argmax p(C) * N(f1_k | mu_C,k, sigma_C,k^2) * N(f2_k | mu_C,k, sigma_C,k^2)
        p_male_given = p_male * normpdf(height, mu_male(1), var_height_male) * normpdf(weight, mu_male(2), var_weight_male);
        
        p_female_given = p_female * normpdf(height, mu_female(1), var_height_female) * normpdf(weight, mu_female(2), var_weight_female);
        
        if p_male_given > p_female_given
            classification = 'Male';
        else
            classification = 'Female';
        end
        
        fprintf('Person %d (%.0f cm, %.0f kg): %s (Male: %.2e, Female: %.2e)\n', ...
                i, height, weight, classification, p_male_given, p_female_given);
    end

    % Contour plot
    figure;
    hold on;
    contour(H, W, pdf_male, 20, 'r', 'LineWidth', 1.5);
    contour(H, W, pdf_female, 20, 'b', 'LineWidth', 1.5);
    xlabel('Height (cm)');
    ylabel('Weight (kg)');
    title('2D Distribution Contours');
    legend('Male', 'Female');
    grid on;
    % Plot the points
    plot(f1(1), f1(2), 'ko', 'MarkerFaceColor', 'g', 'DisplayName', 'Person 1');
    plot(f2(1), f2(2), 'ko', 'MarkerFaceColor', 'm', 'DisplayName', 'Person 2');
    plot(f3(1), f3(2), 'ko', 'MarkerFaceColor', 'c', 'DisplayName', 'Person 3');
    hold off;
   
%% Bayes Klassifikator
%  Variablen abhängig, mehrdimensionale Normalverteilung

    % TODO
    fprintf('\n=== Full Bayes Classification (with covariance) ===\n');
    for i = 1:3
        person = persons{i};
        
        % Full Bayes: argmax p(C) * N(f^i | mu_C, Sigma_C)
        % Uses multivariate normal distribution with full covariance matrix
        p_male_given = p_male * mvnpdf(person, mu_male, cov_male);
        
        p_female_given = p_female * mvnpdf(person, mu_female, cov_female);
        
        if p_male_given > p_female_given
            classification = 'Male';
        else
            classification = 'Female';
        end
        
        fprintf('Person %d (%.0f cm, %.0f kg): %s (Male: %.2e, Female: %.2e)\n', ...
                i, person(1), person(2), classification, p_male_given, p_female_given);
    end