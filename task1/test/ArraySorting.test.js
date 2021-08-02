const ArraySorting = artifacts.require("./ArraySorting.sol");
const chai = require("./setupchai.js");
const BN = web3.utils.BN;
const expect = chai.expect;

contract("ArraySorting", accounts => {
    const customArr = [10, 3, 1, 2, 4, 5, 7, 8, 9, 6, 11];
    const sortedOddArr = [1, 3, 5, 7, 9, 11];
    const sortedEvenArr = [10, 8, 6, 4, 2];
    const sortedArr = [2, 4, 6, 8, 10, 11, 9, 7, 5, 3, 1];
    let ArraySortingInstance;

    beforeEach(async function() {
      ArraySortingInstance = await ArraySorting.new();
    });

    it("Odd numbers order by Asc", async () => {
      let result = await ArraySortingInstance.deleteEvenAndOrderNumbersByAsc(customArr);

      for(i=0; i < sortedOddArr.length; i++) {
        expect(result.logs[0].args.array[i]).bignumber.equal(new BN(sortedOddArr[i]));
      }
    });

    it("Even numbers order by Desc", async () => {
      let result = await ArraySortingInstance.deleteOddAndOrderNumbersByDesc(customArr);

      for(i=0; i < sortedEvenArr.length; i++) {
        expect(result.logs[0].args.array[i]).bignumber.equal(new BN(sortedEvenArr[i]));
      }
    });

    it("Asc Even Numbers Then Desc Odd Numbers", async () => {
      let result = await ArraySortingInstance.ascEvenNumbersThenDescOddNumbers(customArr);

      for(i=0; i < sortedArr.length; i++) {
        expect(result.logs[0].args.array[i]).bignumber.equal(new BN(sortedArr[i]));
      }
    });
});