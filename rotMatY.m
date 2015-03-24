function R = rotMatY(phi)

R = [ cos(phi),     0,  sin(phi); 
        0     ,     1,   0;
      -sin(phi),    1,  cos(phi) ];
end
