//
//  MathUtilities.h
//  CircularProgressBar
//
//  Created by nsh on 05/07/13.
//  Copyright (c) 2013 Robosoft. All rights reserved.
//

#ifndef CircularProgressBar_MathUtilities_h
#define CircularProgressBar_MathUtilities_h

#ifdef __cplusplus
extern "C"
{
#endif
    
    //Converts degrees to radians.
    float DegreesToRadians(float degrees);
    
    //Maps values between 0 to 1 to 0 to 2* PI radians.
    float UnitValueToRadians(float unitValue);


#ifdef __cplusplus
}
#endif

#endif
