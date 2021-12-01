const fs = require('fs')

/**
 * Counts the number of depth increases in a list within a window
 * @param {Array} list 
 * @param {Number} window 
 * @returns Number of depth increases
 */
const depthIncreases = (list, window) => {
    var depthIncreases = 0
    // Use a filter to see how many increases existed.
    for(var i = window; i < list.length; i++) {
        depthIncreases += list[i] > list[i - window] ? 1 : 0
    }
    return depthIncreases
}

try {
    // Read the input.txt file
    const data = fs.readFileSync('input.txt', 'utf-8')
    // Convert to array and to number
    const numberArray = data
                            .toString()
                            .split('\n')
                            .map(number => parseInt(number))
    // Print number of increases
    console.log('Number of times depth increases:',depthIncreases(numberArray, 1)) // 1st Challenge
    console.log('Sliding Number of times depth increases:',depthIncreases(numberArray, 3)) // 2nd Challenge
} catch (err) {
    console.error(err)
}