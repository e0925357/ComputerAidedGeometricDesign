function [ c ] = decasteljau( b, t )
%DECASTELJAU Summary of this function goes here
%   Detailed explanation goes here

hold on;

%Create the matrix for the intermediate solutions
c = zeros(size(b, 1), size(b, 2) - 1);

%Iterate until there is only one control point left
while (size(b, 2) > 1)
    %Get the current degree of the curve
    n = size(b, 2) - 1;

    for i = 1 : n
        %For each control point in this step: compute the next
        %interpolation
        c(:,i) = (1-t).*b(:,i) + t.*b(:,i+1,:);
    end
    
    %Plot the current step
    plot(c(1, 1:n), c(2, 1:n), '-r')
    
    %Wait for a button press
    title('Press a button or click to cotinue!')
    waitforbuttonpress();
    
    %Copy the results to the control point matrix
    b = c(:, 1:n, :);
end

%Now there is only one control point left - that's our solution
c = b(:, 1, :);

hold off;

end

