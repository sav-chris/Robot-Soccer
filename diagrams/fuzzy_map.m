

%Distance Angle Matricies
				% columns: goal angle	% assumed
				% rows: ball angle
				
				% if goal is far to the left:
					% if ball is far to the right, 
				% original
   largeDist = [ [P  P  P  P  P ]; 
                 [P  P  P  P  P ];
                 [N  N  P  P  Z ];
                 [N  N  N  Z  Z ];
                 [N  N  N  Z  N ]];
          
positiveDist = [ [P  P  P  LP LP ]; 
                 [Z  Z  P  P  LP ];
                 [N  N  Z  P  P  ];
                 [LN N  N  Z  Z  ];
                 [LN LN N  N  N  ]];
             
    zeroDist = [ [P  P  P  LP LP ]; 
                 [Z  P  P  LP LP ];
                 [N  N  Z  P  P  ];
                 [LN LN N  N  Z  ];
                 [LN LN N  N  N  ]];
				 
				 
				 % new
   largeDist = [ [N  Z  P  P  P ]; 
                 [P  Z  N  N  LN ];
                 [P  P  Z  N  N ];
                 [LP  P  P  Z  N ];
                 [P  P  P  Z  N ]];
          
positiveDist = [ [P  P  P  LP LP ]; 
                 [Z  Z  P  P  LP ];
                 [N  N  Z  P  P  ];
                 [LN N  N  Z  Z  ];
                 [LN LN N  N  N  ]];
             
    zeroDist = [ [P  P  P  LP LP ]; 
                 [Z  P  P  LP LP ];
                 [N  N  Z  P  P  ];
                 [LN LN N  N  Z  ];
                 [LN LN N  N  N  ]];