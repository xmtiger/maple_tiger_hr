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

describe("Test Root Controller", function(){
    beforeEach(module('app'));
    
    var $controller_test;
    var $scope_test;
    
    beforeEach(inject(function(_$controller_,$rootScope){
        //create a new scope that inherits the rootScope.
        $scope_test = $rootScope.$new();
        
        $controller_test = _$controller_;
        $controller_test = $controller_test('rootController', {$scope:$scope_test});
    }));
    
    describe('test tabs', function(){
        it("set the tab0 name as testTab0", function(){
                        
            $scope_test.currentTab.title = 'testTab0';
            expect($scope_test.currentTab.title).toEqual('testTab0');
        });
    });
});

describe("Test Root Controller 2", function(){
    beforeEach(module('app'));
    
    //var controller_test;
    var scope_test; 
    var rootScope_test;
    
    beforeEach(inject(function(_$controller_,$rootScope){
        //create a new scope that inherits the rootScope.
        scope_test = $rootScope.$new();
        rootScope_test = $rootScope;
        //controller_test = _$controller_;
        // to get scope of the rootController
        _$controller_('rootController', {$scope:scope_test});
    }));
    
    describe('test tabs', function(){
        it("set the tab0 name as testTab1", function(){
                        
            scope_test.currentTab.title = 'testTab1';
            expect(scope_test.currentTab.title).toEqual('testTab1');
        });
    });
    
    describe('test send and receive messages', function(){
        it('should receive the alert message', function(){
            var msg = {type: 'success', msg: 'test message'};
            rootScope_test.$broadcast('Alert_Msg', msg);
            
            expect(scope_test.alert.msg).toEqual(msg.msg);
        });
    });
});