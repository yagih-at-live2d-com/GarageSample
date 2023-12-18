using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Live2D.Cubism.Garage
{
    public class CheckMaskLimit : MonoBehaviour
    {
        [SerializeField] private GameObject _clipping;
        private List<GameObject> _clippings = new List<GameObject>();
        private int _count = 0;
        private bool _onAddButton = false;
        private bool _onRemoveButton = false;
        private float _time = 0;
        [SerializeField] private Text _counter;

        void Update()
        {
            if (_onAddButton)
            {
                _time += Time.deltaTime;
                if (_time > 0.05f)
                {
                    Add();
                    _time = 0;
                }
            }

            if (_onRemoveButton)
            {
                _time += Time.deltaTime;
                if (_time > 0.05f)
                {
                    Remove();
                    _time = 0;
                }
            }
        }

        private void Add()
        {
            var prefab = Instantiate(_clipping, new Vector3(_count % 10 - 4.5f, -_count / 10 + 2f, 0), transform.rotation);
            _clippings.Add(prefab);
            _count += 1;
            _counter.text = _count.ToString();
        }

        private void Remove()
        {
            if (_count > 0)
            {
                Destroy(_clippings[_count - 1]);
                _clippings.RemoveAt(_count - 1);
                _count -= 1;
                _counter.text = _count.ToString();
            }
        }

        //Called by Event Trigger
        public void OnAddButtonDown()
        {
            Add();
            _onAddButton = true;
        }

        //Called by Event Trigger
        public void OnAddButtonUp()
        {
            _onAddButton = false;
            _time = 0;
        }

        //Called by Event Trigger
        public void OnRemoveButtonDown()
        {
            Remove();
            _onRemoveButton = true;
        }

        //Called by Event Trigger
        public void OnRemoveButtonUp()
        {
            _onRemoveButton = false;
            _time = 0;
        }
    }
}