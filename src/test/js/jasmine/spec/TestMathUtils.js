describe("Test Suite", function(){
	
	var calc;
	
	beforeEach(function(){
		calc = new MathUtils();
	});
	
	describe("when calc is used to perform basic math operations", function(){
		
		//spec for sum operations
		it("should be able to calculate sum of 3 and 5", function(){
			expect(calc.sum(3,5)).toEqual(8);
		});
		
		it("should be able to calculate multiply 10 to 40", function(){
			expect(calc.multiply(10,40)).toEqual(400);
		});
		
		it("should be able to calculate factorial of 9", function(){
			expect(calc.factorial(9)).toEqual(362880);
		});
		
		it("should be able to throw error in factorial operation when the number is negative", function(){
			expect(function(){
				calc.factorial(-7)
			}).toThrowError(Error);
		});			
	});
});

describe("Test with spies", function(){
    var calc;

    beforeEach(function(){
            calc = new MathUtils();
            spyOn(calc, 'sum');
    });

    describe("when calc is used to perform math operations", function(){
            it("should be able to calculate sum of 6 and 9", function(){
                    calc.sum(6,9);

                    //verify if it get executed
                    expect(calc.sum).toHaveBeenCalled();
                    expect(calc.sum).toHaveBeenCalledWith(6,9);
            });
    });
});