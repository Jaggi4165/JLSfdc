export const deepClone = obj => JSON.parse(JSON.stringify(obj));

export const comparator = (field, reverse, primer) => {
    reverse = reverse.toUpperCase() === 'ASC' ? 1 : -1;

    const key = primer ? (x) => { return primer(x[field])} : (x) => { return x[field]};

    return (a, b) => {
        if (field === 'createdDate') {
            a = new Date(key(a));
            b = new Date(key(b));
        } else {
            a = key(a);
            b = key(b);
        }
        return reverse * ((a > b) - (b > a));
    };
}