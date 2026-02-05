const removeBoard = (e) => {
  const tr = e.target.parentElement.parentElement; // 삭제버튼기준 tr선택.
  const bno = tr.children[0].innerText; // 글번호.

  fetch("http://localhost:3000/board_delete/" + bno)
    .then((resp) => resp.json())
    .then((data) => {
      console.log(data);
      if (data.retCode == "OK") {
        // 화면에서 row 삭제.
        tr.remove();
      } else {
        alert("처리중 예외 발생.");
      }
    })
    .catch((err) => {
      console.log(err);
    });
};

function makeRow(elem = {}) {
  const tr = document.createElement("tr");
  // 보여줄 항목.
  for (let prop of ["BOARD_NO", "TITLE", "WRITER"]) {
    const td = document.createElement("td");
    td.innerHTML = elem[prop];
    tr.appendChild(td);
  }
  // td,button 시작.
  const td = document.createElement("td");
  const btn = document.createElement("button");
  btn.innerHTML = "삭제";
  td.appendChild(btn);
  tr.appendChild(td);

  // btn에 이벤트 등록.
  btn.addEventListener("click", removeBoard);

  // 작업 반환.
  return tr;
}