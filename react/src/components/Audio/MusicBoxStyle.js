export const MusicBoxStyle = theme => ({
  
  root: {
    display: 'flex',
  },
  title: {
    flexGrow: 1,
  },
  paper: {
    position: 'absolute',
    //backgroundColor: theme.palette.background.paper,
    backgroundColor:"#000",
    border: '2px solid #fff',
    boxShadow: theme.shadows[5],
    padding: theme.spacing(2, 4, 3),
    display: 'flex',
    overflow: 'auto',
    flexDirection: 'column',
    borderRadius: 15,
    width:"760px"

  },
  modal: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: "50% !important"
  },

  imgcover: {
    width:"330px",
    height:"330px",

  },
});