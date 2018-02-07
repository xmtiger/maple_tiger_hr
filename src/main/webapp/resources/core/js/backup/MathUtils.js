
MathUtils = function(){};

MathUtils.prototype.sum = function(num1 , num2) {
	return num1 + num2;
}

MathUtils.prototype.substract = function(num1, num2){
	return num1 - num2;
}

MathUtils.prototype.multiply = function(num1, num2){
	return num1 * num2;
}

MathUtils.prototype.divide = function(num1, num2){
	return num1 / num2;
}

MathUtils.prototype.average = function(num1, num2){
	return (num1 + num2)/2;
}

MathUtils.prototype.factorial = function(number){
	if(number < 0){
		throw new Error("There is no factorial for negative numbers");
	} else if(number === 1 || number === 0){
		return 1;
	} else{
		return number * this.factorial(number -1);
	}	
}