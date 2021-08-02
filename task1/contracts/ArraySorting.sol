// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/**
* Test task 1
* Array sorting algorithm in three variations:
* 1. deleteEvenAndOrderNumbersByAsc
* 2. deleteOddAndOrderNumbersByDesc
* 3. ascEvenNumbersThenDescOddNumbers
*
**/
contract ArraySorting {
    event Answer(uint256[] array);
    
    enum Parity {Odd, Even}
    
    // Sorting by ascending or descending order.
    enum SortingFlag {Asc, Desc}
    
    uint256[] _array;
    
    /**
    * Remove all even numbers from the array and sort the remaining elements in ascending order.
    *
    **/
    function deleteEvenAndOrderNumbersByAsc(uint256[] memory _arr) public {
        require(_arr.length > 0);
        
        arrayParity(_arr, Parity.Odd);
        
        quickSort(0, int(_array.length - 1), SortingFlag.Asc);
        
        emit Answer(_array);

        delete _array;
    }
    
    /**
    * Remove all odd numbers from the array and reverse the remaining elements.
    *
    **/
    function deleteOddAndOrderNumbersByDesc(uint256[] memory _arr) public {
        require(_arr.length > 0);
        
        arrayParity(_arr, Parity.Even);
        
        quickSort(0, int(_array.length - 1), SortingFlag.Desc);
        
        emit Answer(_array);
        
        delete _array;
    }
    
    /**
     * Modified version of Partion Serting method
     * 
     * original (Method 1) in https://www.geeksforgeeks.org/sort-even-numbers-ascending-order-sort-odd-numbers-descending-order/
     * 
     **/
    function ascEvenNumbersThenDescOddNumbers(uint256[] memory _arr) public {
        uint256 left;
        uint256 right = _arr.length - 1;
        int evenNumbersCounter;
     
        while (left < right)
        {
            // Find first even number
            // from left side.
            while (_arr[left] % 2 == 0)
            {
                left++;
                evenNumbersCounter++;
            }
     
            // Find first odd number
            // from right side.
            while (_arr[right] % 2 != 0 && left < right)
                right--;
     
            // Swap even number present on left and odd
            // number right.
            if (left < right)
                (_arr[left], _arr[right]) = (_arr[right], _arr[left]);
        }
        
        _array = _arr;
        
        quickSort(0, evenNumbersCounter-1, SortingFlag.Asc);
        quickSort(evenNumbersCounter, int(_array.length - 1), SortingFlag.Desc);
        
        emit Answer(_array);
        
        delete _array;
    }
    
    function arrayParity(uint256[] memory _arr, Parity _parity) internal {
        for(uint256 i; i < _arr.length; i++) {
            if((_parity == Parity.Odd && _arr[i] % 2 != 0) || (_parity == Parity.Even && _arr[i] % 2 == 0)) {
                _array.push(_arr[i]);
            }
        }
    }
    
    
    /**
     * Modified version of quickSort
     * 
     * original https://gist.github.com/subhodi/b3b86cc13ad2636420963e692a4d896f
     * 
     **/
    function quickSort(int _left, int _right, SortingFlag _flag) internal {
        int i = _left;
        int j = _right;

        if (_left == _right) return;

        uint256 pivot = _array[uint256(_left + (_right - _left) / 2)];
        
        while (i <= j) {
            if(_flag == SortingFlag.Asc) {
                while (_array[uint256(i)] < pivot) i++;
                while (pivot < _array[uint256(j)]) j--;
            } else {
                while (_array[uint256(i)] > pivot) i++;
                while (pivot > _array[uint256(j)]) j--;
            }
            
            if (i <= j) {
                (_array[uint256(i)], _array[uint256(j)]) = (_array[uint256(j)], _array[uint256(i)]);
                i++;
                j--;
            }
        }
        
        if (_left < j)
            quickSort(_left, j, _flag);
        
        if (i < _right)
            quickSort(i, _right, _flag);
    }
}
