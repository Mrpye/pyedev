

function GetWidth() {
  return document.documentElement.clientWidth * 0.9;
}
function GetHeight() {
  return document.documentElement.clientHeight * 0.8;
}
export const YouTubeBoxStyle = theme => ({

  root: {
    display: 'flex',
  },
  title: {
    flexGrow: 1,
  },
  paper: {
    position: 'absolute',
    //backgroundColor: theme.palette.background.paper,
    backgroundColor: "#000",
    border: '2px solid #fff',
    boxShadow: theme.shadows[5],
    padding: theme.spacing(2, 4, 3),
    display: 'flex',
    overflow: 'auto',
    flexDirection: 'column',
    borderRadius: 15,
    width: "90%",
    height:  "90%"

  },
  modal: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: "50% !important",
  },
  wrapper: {
    position: 'relative',
    paddingTop: 'calc(315 / 560 * 80%)'
  },
  player: {
    position: 'absolute',
    top: 0,
    left: 0,
    width: '100%',
    height: '100%',
  },
  imgcover: {
    width: "330px",
    height: "330px",

  },
});