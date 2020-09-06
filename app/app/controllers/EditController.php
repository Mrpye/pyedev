<?php
class EditController extends BaseAdminController
{

    public function beforeroute()
    {
        $this->f3->set('level',  $this->f3->get('SESSION.level'));
        if ($this->f3->get('SESSION.user') === null) {
            $this->f3->reroute('/login');
            exit;
        }
    }

    private function Common()
    {
        $db_res=$this->db->exec("SELECT * FROM dashboard_list;");//Run the sql and get the data
        $this->f3->set('dashboards', $db_res);
        $db_tables = $this->db->exec("SELECT table_name FROM information_schema.tables WHERE table_name LIKE 'data_%';"); //Run the sql and get the data
        $this->f3->set('data_tables', $db_tables);
        $data_edit = $this->db->exec("SELECT name,icon FROM forms;"); //Run the sql and get the data
        $this->f3->set('data_edit', $data_edit);
        $widget_list = $this->db->exec("SELECT name FROM widget_config;"); //Run the sql and get the data
        $this->f3->set('widget_list', $widget_list);
        $scheme_list = $this->db->exec("SELECT name FROM scheme;"); //Run the sql and get the data
        $this->f3->set('scheme_list', $scheme_list);
    }

    private function LoadContent($path)
    {
        $this->notemplate = true;
        $data = Template::instance()->render($path);
        $this->notemplate = false;
        return $data;
    }

    //*********
    //Main Site
    //*********
    public function index()
    {
        $this->Common();

        $form_data = new DataManager($this->db, "forms");
        $form_data->getByName($this->f3->get('PARAMS.name'));
        if ($form_data->countResults() == 0) {$this->f3->error(404, 'value missing');}
        if (empty($form_data->view)) {$this->f3->error(404, 'value missing');}
        $fields = json_decode($form_data->view, true);
        $field_scheme = $this->db->schema($form_data->table);
        $data = new DataManager($this->db, $form_data->table);

        $this->f3->set('scheme', $field_scheme);
        $this->f3->set('id_key', $fields['key']);
        $this->f3->set('fields', $fields['fields_scheme']);
        $this->f3->set('form_name', $form_data->name);
        $this->f3->set('data', $data->all());

        $this->f3->set('page_head', 'Admin Page');
        $this->f3->set('content2', $this->LoadContent('add_edit_view/view.js'));
        $this->f3->set('content', 'add_edit_view/view.htm');
    }

    public function edit()
    {
        $this->Common();

        $form_data = new DataManager($this->db, "forms");
        $form_data->getByName($this->f3->get('PARAMS.name'));
        if ($form_data->countResults() == 0) {$this->f3->error(404, 'value missing');}
        if (empty($form_data->view)) {$this->f3->error(404, 'value missing');}
        $fields = json_decode($form_data->edit, true);
        $field_scheme = $this->db->schema($form_data->table);
        $data = new DataManager($this->db, $form_data->table);

        if ($this->f3->exists('POST.update')) {
            //print_r($this->f3->get('POST')); die();
            $data->edit($this->f3->get('POST.id'));

            $this->f3->reroute('/add_edit_view/view/' . $form_data->name);
        } else {
            $data->getById($this->f3->get('PARAMS.id'));

            // print_r(json_encode($fields)); die();

            $this->f3->set('scheme', $field_scheme);
            $this->f3->set('fields', $fields['fields_scheme']);
            $this->f3->set('data', $data);
            $this->f3->set('id_value', $this->f3->get('PARAMS.id'));
            $this->f3->set('id_key', $fields['key']);
            $this->f3->set('form_name', $form_data->name);
            $this->f3->set('page_head', 'Admin Page');
            //$this->f3->set('content2', $this->LoadContent('add_edit_view/view.js'));
            $this->f3->set('content', 'add_edit_view/edit.htm');

        }

    }

    public function delete()
    {
        $this->Common();
        $form_data = new DataManager($this->db, "forms");
        $form_data->getByName($this->f3->get('PARAMS.name'));
        if ($form_data->countResults() == 0) {$this->f3->error(404, 'value missing');}
        if (empty($form_data->view)) {$this->f3->error(404, 'value missing');}
        $data = new DataManager($this->db, $form_data->table);
        if ($this->f3->exists('PARAMS.id')) {
            //$data->edit($this->f3->get('PARAMS.id'));
            $data->delete($this->f3->get('PARAMS.id'));
        }
        $this->f3->reroute('/add_edit_view/view/'.$form_data->table);
    }

    public function add()
    {
        $this->Common();

        $form_data = new DataManager($this->db, "forms");
        $form_data->getByName($this->f3->get('PARAMS.name'));
        if ($form_data->countResults() == 0) {$this->f3->error(404, 'value missing');}
        if (empty($form_data->view)) {$this->f3->error(404, 'value missing');}
        $fields = json_decode($form_data->edit, true);
        $field_scheme = $this->db->schema($form_data->table);
        $data = new DataManager($this->db, $form_data->table);

        if ($this->f3->exists('POST.create')) {
            $data->add();
            $this->f3->reroute('/add_edit_view/view/' . $form_data->name);
        } else {
            $this->f3->set('scheme', $field_scheme);
            $this->f3->set('fields', $fields['fields_scheme']);
            //$this->f3->set('data', $data);
            $this->f3->set('id_value', $this->f3->get('PARAMS.id'));
            $this->f3->set('id_key', $fields['key']);
            $this->f3->set('form_name', $form_data->name);
            $this->f3->set('page_head', 'Admin Page');
            //$this->f3->set('content2', $this->LoadContent('add_edit_view/view.js'));
            $this->f3->set('content', 'add_edit_view/add.htm');

        }

    }
}
