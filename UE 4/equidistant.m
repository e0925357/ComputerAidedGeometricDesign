function [ v ] = equidistant( numOfElements, repetition )
%UNTITLED Creates a vector of equidistant numbers between 0 and 1 with
%repetition times repeating the 0 and 1.

v = zeros(1, numOfElements);
v(repetition:numOfElements-repetition+1) = 0:(1/(numOfElements-repetition*2 + 1)):1;

if(repetition > 1)
    v(numOfElements-repetition+1:numOfElements) = 1;
end

end

