const express = require("express");
const { getConnection, oracledb } = require("./db");
const cors = require("cors");
const app = express(); // 익스프레스 모듈을 활용 실체기능.

// 셋업추가. CORS
app.use(cors()); // CORS 요청 처리.
app.use(express.json()); // body 영역에 json 처리.

// url -> 실행기능. 라우팅.
app.get("/", (req, res) => {
  res.send("OK");
});
// 글목록 조회.
app.get("/board", async (req, res) => {
  const conn = await getConnection();
  const { metaData, rows } = await conn.execute(
    `SELECT * FROM board ORDER BY 1`,
  );
  const json = JSON.stringify(rows); // 객체->json문자열.
  res.send(json); // 응답처리.
});

// 글삭제.
app.get("/board_delete/:bno", async (req, res) => {
  console.log(req.params.bno); // req.params 속성.
  const conn = await getConnection();
  const result = await conn.execute(
    `DELETE FROM board WHERE board_no = :bno`,
    { bno: req.params.bno },
    { autoCommit: true },
  );
  // 정상삭제되면 OK, 삭제못하면 NG
  if (result.rowsAffected) {
    res.json({ retCode: "OK" }); // { "retCode": "OK" }
  } else {
    res.json({ retCode: "NG" });
  }
});

// 수정.
app.get("/board_update/:bno/:title/:content", async (req, res) => {
  console.log(req.params); // req.params 속성.
  const conn = await getConnection();
  const result = await conn.execute(
    `update board
        set title = :title
           ,content = :content
     where board_no = :bno `,
    {
      bno: req.params.bno,
      title: req.params.title,
      content: req.params.content,
    },
    { autoCommit: true },
  );
  // 정상삭제되면 OK, 삭제못하면 NG
  if (result.rowsAffected) {
    res.json({ retCode: "OK" }); // { "retCode": "OK" }
  } else {
    res.json({ retCode: "NG" });
  }
});

// 등록.
app.post("/board_insert", async (req, res) => {
  console.log(req.body); // req.params 속성.
  const {title,content,writer} = req.body;
  const conn = await getConnection();
  const result = await conn.execute(
    `insert into board (board_no, title, writer, content)
     values((select nvl(max(board_no),0)+1 from board), :title, :writer, :content)
     returning board_no into :bno `,
    {
      bno: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER },
      title: req.body.title,
      content: req.body.content,
      writer: req.body.writer,
    },
    { autoCommit: true },
  );
  console.log(result.outBinds.bno[0]);

  // 정상삭제되면 OK, 삭제못하면 NG
  if (result.rowsAffected) {
    res.json({ 
      retCode: "OK", 
      BOARD_NO:result.outBinds.bno[0], 
      TITLE:title,
      WRITER:writer,
      CONTENT:content,}); // { "retCode": "OK" }
  } else {
    res.json({ retCode: "NG" });
  }
});

app.listen(3000, () => {
  console.log("http://localhost:3000");
}); // 서버실행.