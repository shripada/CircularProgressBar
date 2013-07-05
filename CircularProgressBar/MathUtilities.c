//
//  MathUtilities.c
//  CircularProgressBar
//
//  Created by nsh on 05/07/13.
//  Copyright (c) 2013 Robosoft. All rights reserved.
//

#include <stdio.h>

float DegreesToRadians(float degrees)
{
    return degrees *  0.0174532925;
}

float UnitValueToRadians(float unitValue)
{
    
    if(unitValue > 0.0)
    {
        return  unitValue * (22/7.0) * 2;
    }
    else
        return 0.0;
}