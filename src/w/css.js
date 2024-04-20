let remSizeCache;

/**
 * Fetches document current rem size.
 */
export function getRemSize() {
  if (!remSizeCache) {
    const htmlElement = document.querySelector("html");
    const htmlStyles = window.getComputedStyle(htmlElement);
    const pxSize = htmlStyles.getPropertyValue("font-size");
    remSizeCache = parseFloat(pxSize);
  }

  return remSizeCache;
}

/**
 * Turns a rem string "1.25rem" into a px string "20px"
 */
export function remToPx(remString) {
  const remSize = getRemSize();
  const pxValue = parseFloat(remString) * remSize;

  return `${pxValue}px`;
}
